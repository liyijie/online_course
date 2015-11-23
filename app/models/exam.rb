# == Schema Information
#
# Table name: exams
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  sub_course_id :integer
#  total_score   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  correct_count :integer          default(0)
#  all_count     :integer          default(0)
#

class Exam < ActiveRecord::Base
  belongs_to :user
  belongs_to :sub_course
  has_many :exam_items, dependent: :destroy

  # 根据页面传入的答题params来更新exam对象
  # 创建Exam对象的过程中，也会创建对应的ExamItem对象
  # 输入参数，key为question.id，value为option_value
  def generate_by_answer_params answer_params
    index = 0
    answer_params.each do |question_id, answer|
      item = self.exam_items.build item_index: index,  answer: answer, question_id: question_id

      # 与问题的正确答案对比考试这题的答案是否正确
      question = Question.find_by_id item.question_id
      next if question.blank?
      if answer.try(:strip) == question.correct_option.try(:strip)
        item.correct = true
        self.correct_count += 1
      else
        item.correct = false
      end
      self.all_count += 1
      index += 1
      item.save
    end

    # 计算得分
    self.total_score = all_count == 0 ? 0 : correct_count * 100 / all_count
    self.save
  end


  # 获取考试回答正确的题
  def right_items
    rights = []
    self.exam_items.each_with_index {|item,index| rights << (index + 1) if item.correct}
    rights
  end

  # 获取考试回答错误的题
  def wrong_items
    wrong = []
    self.exam_items.each_with_index {|item,index| wrong << (index + 1) if !item.correct}
    wrong
  end

  # 获取考试没有回答的题
  def no_answer_items
    no_answer = []
    self.exam_items.each_with_index {|item,index| no_answer << (index + 1) if item.answer.blank?}
    no_answer
  end
end
