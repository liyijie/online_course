# == Schema Information
#
# Table name: user_papers
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  paper_id        :integer
#  answered        :boolean          default(FALSE)
#  total_score     :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  evaluated       :boolean          default(FALSE)
#  objective_total :integer          default(0)
#

class UserPaper < ActiveRecord::Base
  scope :answered, -> {where(answered: true)}

  belongs_to :user
  belongs_to :paper
  has_many :answers, dependent: :destroy

  # 根据页面传入的答题params来更新exam对象
  # 创建Exam对象的过程中，也会创建对应的ExamItem对象
  # 输入参数，key为question.id，value为option_value
  def generate_by_answer_params answer_params

    objective_total = 0

    answer_params.each do |question_id, answer_content|
      question = PaperQuestion.where(id: question_id).first
      answer = self.answers.build content: answer_content, paper_question_id: question_id, score: 0
      if question.single?
        # 单选题处理
        if answer_content.try(:strip) == question.correct_answer.try(:strip)
          answer.correct = true
          answer.score = question.signal_score
          objective_total += question.signal_score
        else
          answer.correct = false
        end
      elsif question.multi?
        # 多选题处理
        answer.content = answer_content.join('')
        if question.correct_answer.include?(answer.content)
          # 全对满分，半对一半分
          multi_score = question.correct_answer.try(:strip).size == answer.content.try(:strip).size ? question.signal_score : question.signal_score/2
          answer.score = multi_score
          objective_total += multi_score
        end
      elsif question.judge?
        # 判断题处理
        if answer_content.try(:strip) == question.correct_answer.try(:strip)
          answer.correct = true
          answer.score = question.signal_score
          objective_total += question.signal_score
        else
          answer.correct = false
        end
      end 
      answer.save 
    end

    self.answered = true
    self.objective_total = objective_total
    self.save
  end

  # 根据页面传入的答题params来更新学生考试的分数
  # 创建Exam对象的过程中，也会创建对应的ExamItem对象
  # 输入参数，key为question.id，value为option_value
  def generate_by_answer_score(answer_score)
    self.total_score = objective_total
    answer_score.each do |answer_id, score|
      answer = Answer.where(id: answer_id).first
      if answer.present?
        answer.score = (score || 0).to_i
        answer.save
        self.total_score += (score || 0).to_i
      end
    end
    self.evaluated = true
    self.save
  end

end
