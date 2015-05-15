# == Schema Information
#
# Table name: sub_courses
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  name       :string
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SubCourse < ActiveRecord::Base
  belongs_to :course
  has_many :questions
end
