class ExamsController < ApplicationController
  before_action :authenticate_user!
	def new
		@sub_course = SubCourse.find_by_id(params[:sub_course_id])
		@questions = @sub_course.questions 
	end

	def create
		answer_params = {}
		sub_course = SubCourse.find_by_id(params[:exam][:sub_course_id])
		@exam = Exam.new
		sub_course.questions.each_with_index do |question, index|
			val = "option_" + index.to_s
			qid = question.id
		  answer_params = {qid => params[val]}
		  @exam.user_id = current_user.id
		  @exam.generate_by_answer_params(answer_params)
		end
	end

	private
	def exam_params
		params.require(:exam).permit(:user_id, :sub_course_id, :total_score, :correct_count, :all_count)
	end
end