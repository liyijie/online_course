# == Schema Information
#
# Table name: teacher_courses
#
#  id         :integer          not null, primary key
#  teacher_id :integer
#  course_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TeacherCourse < ActiveRecord::Base
	validates :teacher_id, :course_id, presence: true

  belongs_to :teacher
  belongs_to :course
end
