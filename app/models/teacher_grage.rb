# == Schema Information
#
# Table name: teacher_grages
#
#  id         :integer          not null, primary key
#  teacher_id :integer
#  grade_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TeacherGrage < ActiveRecord::Base
end
