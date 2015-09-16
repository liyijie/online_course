# == Schema Information
#
# Table name: user_papers
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  paper_id    :integer
#  answered    :boolean          default(FALSE)
#  total_score :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserPaper < ActiveRecord::Base
  belongs_to :user
  belongs_to :paper

end
