class ExamsController < ApplicationController
  before_action :authenticate_user!
	def new
		@sub_course = SubCourse.find_by_number(params[:sub_course_number])
		@questions = @sub_course.questions 
	end

	def create
		answer_params = {}
		sub_course = SubCourse.find_by_number(params[:exam][:sub_course_number])
		@exam = Exam.new
		sub_course.questions.each_with_index do |question, index|
			val = "option_" + index.to_s
			qid = question.id
		  answer_params = {qid => params[val]}
		  @exam.user_id = current_user.id
		  @exam.sub_course_id = sub_course.id
		  @exam.generate_by_answer_params(answer_params)
		end
	end

	def show
		@exam = Exam.where(id: params[:id]).first
		if @exam.blank?
			flash[:notice] = "查看的试卷不存在"
			redirect_to root_path
		end
	end

	private
	def exam_params
		params.require(:exam).permit(:user_id, :sub_course_id, :total_score, :correct_count, :all_count)
	end
end