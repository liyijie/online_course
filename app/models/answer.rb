# == Schema Information
#
# Table name: answers
#
#  id                :integer          not null, primary key
#  user_paper_id     :integer
#  paper_question_id :integer
#  content           :string(255)
#  score             :integer
#  correct           :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Answer < ActiveRecord::Base
  belongs_to :user_paper
  belongs_to :paper_question
end
