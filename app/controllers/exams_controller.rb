class ExamsController < ApplicationController
	def new
		@sub_course = SubCourse.find_by(params[:sub_course_id])
		@questions = @sub_course.questions 
	end
	def create
		total_score = 0
		answer_params = {}
		sub_course = SubCourse.find_by(params[:sub_course_id])
		@questions = sub_course.questions
		@exam = Exam.new
		@questions.each_with_index do |question, index|
			val = "option_" + index.to_s
		  answer_params = {"#{question.id}": params[val]}
		  @exam.generate_by_answer_params(answer_params)
		end
	end

	private
	def exam_params
		params.require(:exam).permit(:user_id, :sub_course_id, :total_score)
	end
end