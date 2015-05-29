# == Schema Information
#
# Table name: grades
#
#  id           :integer          not null, primary key
#  specialty_id :integer
#  name         :string(255)
#  deleted_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Grade < ActiveRecord::Base
	belongs_to :specialty
	has_many :users, dependent: :destroy
  has_many :teacher_grades, dependent: :destroy
end
