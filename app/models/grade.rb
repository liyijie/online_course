# == Schema Information
#
# Table name: grades
#
#  id           :integer          not null, primary key
#  specialty_id :integer
#  name         :string(255)
#  deleted_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Grade < ActiveRecord::Base
	belongs_to :specialty
	has_many :users, dependent: :destroy
  has_many :exams, through: :users
  has_many :exam_items, through: :exams

  has_many :teacher_grades, dependent: :destroy

  attr_accessor :exam_score

  # 班级某次课后测试分数分析
  # 返回平均分，以及个分数段人数
  def exam_result!(sub_course)
    # A： 90+ ； B：80~90, C：70~80， D：60~70， E：60-
    self.exam_score = { avg_score: 0 , "A" => 0, "B" => 0, "C" => 0, "D" => "0", "E" => 0}

    # 学生总数
    users_count = self.users.count

    # 当前班级当前测验所有考试
    exams = self.exams.where("exams.sub_course_id = ?", sub_course.id).pluck(:total_score)

    if exams.present?
      self.exam_score[:avg_score] = (eval(exams.join("+"))/users_count.to_f).round(2) 
      self.exam_score["A"] = exams.count{ |score| score >= 90 }
      self.exam_score["B"] = exams.count{ |score| score >= 80 && score < 90 }
      self.exam_score["C"] = exams.count{ |score| score >= 70 && score < 80 }
      self.exam_score["D"] = exams.count{ |score| score >= 60 && score < 70 }
      # 60分以下的需加上缺考人数
      self.exam_score["E"] = exams.count{ |score| score < 60 } + (users_count - exams.count)
    end

    exam_score
  end

  # 生成指定班级、指定课程的成绩的xls
  def self.export(grades, sub_course)
    xls_report = StringIO.new
    book = Spreadsheet::Workbook.new

    grades.each do |grade|
      sheet = book.create_worksheet :name => grade.name

      # 课程信息
      sheet.row(0).concat ['专业', grade.specialty.name]
      sheet.row(1).concat ['课程', sub_course.course.name, '测试', sub_course.name]

      # 班级分数信息
      grade.exam_result!(sub_course)
      sheet.row(2).concat [
                          '班级人数', "#{grade.users.count}人",
                          '班级平均分', "#{grade.exam_score[:avg_score]}分", "90以上"
                        ]
      sheet.row(3).concat [
                          '90分以上', "#{grade.exam_score["A"]}人",
                          '80~90分', "#{grade.exam_score["B"]}人",
                          '70~80分', "#{grade.exam_score["C"]}人",
                          '60~70分', "#{grade.exam_score["D"]}人",
                          '60分以下', "#{grade.exam_score["E"]}人"
                        ]

      # 学生得分详细信息
      # title生成
      title = ['学号', '姓名', '得分']
      questions = sub_course.questions
      title += questions.map(&:title)
      sheet.row(5).concat title

      users = grade.users
                    .select("users.id, users.name, users.number, exams.total_score as total_score, 
                      group_concat(exam_items.question_id,':',exam_items.answer) as answers")
                    .joins("left join exams on exams.user_id = users.id and exams.sub_course_id = #{sub_course.id} left join exam_items on exam_items.exam_id = exams.id")
                    .group("users.id")
                    .order("users.number ASC")


      offset = 6 #学生信息起始行
      users.each_with_index do |user, index|
        content = [user.number, user.name, user.total_score]

        # 格式化学生选择的答案
        answers_hash = {}
        if user.answers.present?
          answers = user.answers.split(',')
          answers.each do |answer|
            answers_hash[answer.split(':')[0].to_i] = answer.split(':')[1]
          end
        end
        # 写入学生选择的相应选项
        questions.each do |question|
          content.push(answers_hash[question.id] || '')
        end
        sheet.row(offset + index).concat content
      end
    end

    book.write xls_report
    xls_report.string
  end
end
