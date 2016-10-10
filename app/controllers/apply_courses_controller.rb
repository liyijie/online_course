class ApplyCoursesController < ApplicationController
	def index
		@school_applied_courses = Course.undeleted.school_course.by_year
		@city_applied_courses = Course.undeleted.city_course.by_year
		@school_history_courses = Course.undeleted.school_course - @school_applied_courses
		@city_history_courses = Course.undeleted.city_course - @city_applied_courses
	end
end