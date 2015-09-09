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
      pp eval(exams.join("+"))
      pp users_count
      pp exams.size
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
end
