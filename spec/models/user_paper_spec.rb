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

require 'rails_helper'

RSpec.describe UserPaper, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
