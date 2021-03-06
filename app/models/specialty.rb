# == Schema Information
#
# Table name: specialties
#
#  id         :integer          not null, primary key
#  academy_id :integer
#  name       :string(255)
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  code       :string(255)
#

class Specialty < ActiveRecord::Base
	belongs_to :academy
	has_many :grades, dependent: :destroy
  has_many :users, through: :grades
	has_many :courses

  scope :enabled, -> {where("deleted_at is null")}

  scope :keyword_like, -> (keyword) do
    return all if keyword.blank?
    where(
      'specialties.name LIKE ?
      OR specialties.code LIKE ?
      OR specialties.academy_id LIKE ?',
      "%#{keyword}%",
      "%#{keyword}%",
      "%#{keyword}%"
    )
  end
end
