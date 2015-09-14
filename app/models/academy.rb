# == Schema Information
#
# Table name: academies
#
#  id           :integer          not null, primary key
#  school_id    :integer
#  name         :string(255)
#  deleted_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  academy_code :string(255)
#

class Academy < ActiveRecord::Base
	belongs_to :school
	has_many :specialties, dependent: :destroy
  has_many :users, through: :specialties
	has_many :courses, dependent: :destroy
  has_many :teachers, dependent: :destroy
end
