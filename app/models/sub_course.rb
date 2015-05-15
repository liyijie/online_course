# == Schema Information
#
# Table name: sub_courses
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  name       :string(255)
#  content    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SubCourse < ActiveRecord::Base
  belongs_to :course
  has_many :questions, dependent: :destroy
end
