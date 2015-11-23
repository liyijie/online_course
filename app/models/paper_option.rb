# == Schema Information
#
# Table name: paper_options
#
#  id                :integer          not null, primary key
#  content           :string(255)
#  index_type        :string(255)
#  paper_question_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class PaperOption < ActiveRecord::Base
  belongs_to :paper_question
end
