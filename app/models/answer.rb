class Answer < ActiveRecord::Base
  belongs_to :user_paper
  belongs_to :paper_question
end
