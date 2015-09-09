# == Schema Information
#
# Table name: exam_items
#
#  id          :integer          not null, primary key
#  exam_id     :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  answer      :string(255)
#  correct     :boolean
#  item_index  :integer
#

class ExamItem < ActiveRecord::Base
  belongs_to :exam
  belongs_to :question


  # 统计若干班级某次测试的错误人数
  # 返回值hash， key： question_id, value: 错误的人数
  def self.questions_false_count(grades, sub_course)
    result = {}
    false_count = self.joins(" INNER JOIN `exams` ON `exam_items`.`exam_id` = `exams`.`id` INNER JOIN `users` ON `exams`.`user_id` = `users`.`id`")
                      .where("exams.sub_course_id = ? and users.grade_id in (?) and exam_items.correct = ?", sub_course.id, grades.ids.join(","), false)
                      .group("exam_items.question_id")
                      .pluck("exam_items.question_id,count(exam_items.id)")
    false_count.each do |arr|
      result[arr[0]] = arr[1]
    end
    result
  end
end
