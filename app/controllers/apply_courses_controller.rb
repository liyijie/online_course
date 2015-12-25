class ApplyCoursesController < ApplicationController
	def index
		@college_applied_courses = Course.undeleted.where(college_applied: true, city_applied: false )
		@city_applied_courses = Course.undeleted.where(city_applied: true)
	end
end