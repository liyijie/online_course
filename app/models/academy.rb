# == Schema Information
#
# Table name: academies
#
#  id         :integer          not null, primary key
#  school_id  :integer
#  name       :string
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Academy < ActiveRecord::Base
	belongs_to :school
	has_many :grades
end
