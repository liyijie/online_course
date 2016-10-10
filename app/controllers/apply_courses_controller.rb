class ApplyCoursesController < ApplicationController
	def index
		@school_applied_courses = Course.undeleted.school_course
		@city_applied_courses = Course.undeleted.city_course
	end
end