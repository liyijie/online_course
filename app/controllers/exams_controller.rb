class ExamsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :authenticate_user_or_teacher, only: [:index]

  def index

  end

	def new
		@sub_course = SubCourse.find_by_number(params[:sub_course_number])
		@questions = @sub_course.questions

		#查找判断用户是否已经参加过该次考试
		@exam = Exam.find_by(user_id: current_user.id, sub_course_id: @sub_course.id)
	end

	def test_new
		@sub_course = SubCourse.undeleted.first
		@questions = @sub_course.questions
	end


	def show_test
		@exam = Exam.first
	end

	def create
		sub_course = SubCourse.find_by_number(params[:exam][:sub_course_number])
		@exam = Exam.new
		@exam.user_id = current_user.id
		@exam.sub_course_id = sub_course.id
		@exam.generate_by_answer_params(params[:options])
		flash['notice'] = "恭喜您, 测试提交成功"
		#return redirect_to after_class_courses_path(sub_course.course.number)
		respond_to do |format|
			format.js
		end
	end

	def show
		@exam = Exam.where(id: params[:id]).first
		if @exam.blank?
			flash.now[:notice] = "查看的试卷不存在"
			redirect_to root_path
			return
		end
	end

	private
	def exam_params
		params.require(:exam).permit(:user_id, :sub_course_id, :total_score, :correct_count, :all_count)
	end
end