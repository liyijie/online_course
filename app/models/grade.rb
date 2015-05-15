# == Schema Information
#
# Table name: grades
#
#  id         :integer          not null, primary key
#  academy_id :integer
#  name       :string
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Grade < ActiveRecord::Base
	belongs_to :academy
	has_many :users
end
