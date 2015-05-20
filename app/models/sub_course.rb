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
#  number     :string(255)
#

class SubCourse < ActiveRecord::Base
  acts_as_commentable
  belongs_to :course
  has_many :questions, dependent: :destroy
end
