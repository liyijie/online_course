class CoursesController < ApplicationController
	def index
		@courses = Course.all
	end

	def show
		@course = Course.find_by(number: params[:number])
		@sub_courses = @course.sub_courses
	end
end