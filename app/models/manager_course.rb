# == Schema Information
#
# Table name: manager_courses
#
#  id         :integer          not null, primary key
#  manager_id :integer
#  course_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ManagerCourse < ActiveRecord::Base
  belongs_to :manager
  belongs_to :course
end
