class ExamsController < ApplicationController
	def new
		@sub_course = SubCourse.find_by(params[:sub_course_id])
		@questions = @sub_course.questions 
	end
	def create
	end
end