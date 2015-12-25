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
  belongs_to :exam, dependent: :destroy
  belongs_to :question, dependent: :destroy


  # 统计若干班级某次测试的错误人数
  # 返回值hash， key： question_id, value: 错误的人数
  def self.exam_analyze(grades, sub_course)
    result = {}

    # 答错题数统计
    error_result = {}
    false_count = self.joins(" INNER JOIN `exams` ON `exam_items`.`exam_id` = `exams`.`id` INNER JOIN `users` ON `exams`.`user_id` = `users`.`id`")
                      .where("exams.sub_course_id = ? and users.grade_id in (?) and exam_items.correct = ?", sub_course.id, grades.ids.join(","), false)
                      .group("exam_items.question_id")
                      .pluck("exam_items.question_id,count(exam_items.id)")
    false_count.each do |arr|
      error_result[arr[0]] = arr[1]
    end
    result[:errors] = error_result

    # 各选项选择人数
    options = {}
    select_options = self.joins(" INNER JOIN `exams` ON `exam_items`.`exam_id` = `exams`.`id` INNER JOIN `users` ON `exams`.`user_id` = `users`.`id`")
                          .where("exams.sub_course_id = ? and users.grade_id in (?) and exam_items.answer is not null", sub_course.id, grades.ids.join(","))
                          .group("exam_items.question_id,exam_items.answer")
                          .pluck("exam_items.question_id,exam_items.answer,count(exam_items.id)")

    select_options.each do |arr|
      if options[arr[0]].present?
        options[arr[0]].merge!({ arr[1] => arr[2]} )
      else
        options[arr[0]] = { arr[1] => arr[2]} 
      end
    end
    result[:options] = options

    result
  end
end
