class ExamsController < ApplicationController
	def new
		@sub_course = SubCourse.find_by(params[:sub_course_id])
		@questions = @sub_course.questions 
	end
	def create
		total_score = 0
		@sub_course = SubCourse.find_by(params[:sub_course_id])
		@questions = @sub_course.questions
		@exam = Exam.new(exam_params)
    @questions.each_with_index do |question, index|
    	score = "score_"+index.to_s
    	checked_score = Des.decode(params[:exam][score]).to_i
    	total_score += checked_score
    	p checked_score
    	@exam.exam_items << ExamItem.new(question_id: question.id, exam_id: @exam.id)
    end
    p total_score
    @exam = Exam.new exam_params.merge(total_score: total_score, user_id: 1, sub_course_id: @sub_course.id)
    @exam.save
	end

	private
	def exam_params
		params.require(:exam).permit(:user_id, :sub_course_id, :total_score)
	end
end