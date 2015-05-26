module Admin
	class QuestionsController < ApplicationController
		def index
			@course = Course.find(params[:course_id])
			@sub_course = SubCourse.find(params[:sub_course_id])
		end

		def import
		  Question.import(params[:file])
		end
	end
end