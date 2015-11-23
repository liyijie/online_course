# == Schema Information
#
# Table name: teacher_grades
#
#  id         :integer          not null, primary key
#  teacher_id :integer
#  grade_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TeacherGrade < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :grade
end
