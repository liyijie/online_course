class ApplyCoursesController < ApplicationController
	def index
		@college_applied_courses = Course.where(college_applied: true, city_applied: false )
		@city_applied_courses = Course.where(city_applied: true)
	end
end