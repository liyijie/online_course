# == Schema Information
#
# Table name: papers
#
#  id          :integer          not null, primary key
#  teacher_id  :integer
#  course_id   :integer
#  name        :string(255)
#  content     :text(65535)
#  start_at    :date
#  end_at      :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  total_score :integer
#

class Paper < ActiveRecord::Base
  belongs_to :course
  has_many :user_papers, dependent: :destroy
  has_many :paper_questions, dependent: :destroy

  validates_presence_of :course_id, :name
  validates_presence_of :start_at, :end_at, message: "请输入YYYY-MM-DD格式的日期"

  # 试卷导入
  def import(file)
    spreadsheet = Paper.open_spreadsheet(file)
    header = [:question_type, :signal_score, :title, :correct_answer, :correct_hint]
    options_index = {0 => "A", 1 => "B", 2 => "C", 3 => "D", 4 => "E"}
    begin
      PaperQuestion.transaction do
        total_score = 0 
        self.paper_questions.destroy_all # 删除原来的题
        spreadsheet.each_with_index  do |row, index|
          next if index == 0
          # 题目创建
          paper_question = PaperQuestion.new 
          attrs = Hash[[header, row.slice(0..(header.size - 1))].transpose]
          attrs[:question_type] = PaperQuestion::QUESTIONTYPE.invert[attrs[:question_type]]
          paper_question.attributes = attrs
          paper_question.paper_id = self.id
          paper_question.save!

          total_score += paper_question.signal_score # 总分计算

          # 选择题时保存其选项
          if paper_question.single? || paper_question.multi?
            row.slice(header.size..row.size).each_with_index do |option, index|
              PaperOption.create!(content: option, index_type: options_index[index], paper_question_id: paper_question.id) if options_index[index].present? && option.present?
            end
          end
        end
        self.update(total_score: total_score)
      end
    rescue Exception => e
      puts "===================import======================="
      puts e.message
      puts "===================import======================="
      ActiveRecord::Rollback
    end
    
  end 


  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "未知格式: #{file.original_filename}"
    end
  end


  # 按班级导出成绩单
  def export_by_grade(grade)
    xls_report = StringIO.new
    book = Spreadsheet::Workbook.new

    sheet = book.create_worksheet :name => self.try(:paper).try(:name)

    # 考试信息
    sheet.row(0).concat ['学院', grade.specialty.academy.name]
    sheet.row(1).concat ['专业', grade.specialty.name]
    sheet.row(2).concat ['班级', grade.name]

    user_papers = UserPaper.includes(:user).where(users: {grade_id: grade.id}, user_papers: {paper_id: self.id}).order("users.number asc")

    title = ['学号', '姓名', '得分']
    sheet.row(3).concat title

    offset = 4 #学生信息起始行
    user_papers.each_with_index do |user_paper, index|
      user = user_paper.user
      content = [user.number, user.name, user_paper.total_score]
      sheet.row(offset + index).concat content
    end

    book.write xls_report
    xls_report.string
  end
end
