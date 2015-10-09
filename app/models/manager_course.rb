class ManagerCourse < ActiveRecord::Base
  belongs_to :manager
  belongs_to :course
end
