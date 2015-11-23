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

require 'rails_helper'

RSpec.describe TeacherGrade, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
