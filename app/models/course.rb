class Course < ActiveRecord::Base
	has_many :sub_courses
end
