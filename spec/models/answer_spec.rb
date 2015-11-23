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

require 'rails_helper'

RSpec.describe Answer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
