class CoursesController < ApplicationController
	before_action :authenticate_user! , only: [:course_collect, :course_praise] , if: "!teacher_signed_in?"

	def index
		@academies = Academy.all
		@courses = Course.all
	end

	def show
		@course = Course.find_by(number: params[:number])
		@sub_courses = @course.sub_courses
		@teacher_courses = @course.teacher_courses
	end

	def create
		@course = Course.new(course_params)
		@course.image = Image.new
		@course.image.avatar = params[:course][:image]
		if @course.save
			flash.now[:notice] = "课程创建成功"
			return redirect_to upload_course_ware_teachers_path
		else
			flash.now[:notice] = "课程创建失败"
			return redirect_to upload_course_ware_teachers_path
		end
	end

  #课后作业
	def after_class
		@course = Course.find_by(number: params[:number])
		@teacher_courses = @course.teacher_courses
		@sub_courses = @course.sub_courses
	end


	#课程的收藏或者取消收藏
	def course_collect
		collect_sucess, @collect = Course.course_collect_or_praise params[:course_id], current_user, "collect"
	
		if collect_sucess
	  		respond_to do |format|
	  		format.js {""}
    	end
		else
	 		respond_to do |format|
	  			format.js { render js: "alert('学生登录才可以收藏');" }
    		end
		end 
	end

	#课程点赞或者取消赞
	def course_praise
		praise_sucess, @praise = Course.course_collect_or_praise params[:course_id], current_user, "praise"
	
		if praise_sucess
	  		respond_to do |format|
	  		format.js {""}
    	end
		else
	 		respond_to do |format|
	  			format.js { render js: "alert('学生登录才可以收藏');" }
    		end
		end 
	end

	private
	  def course_params
	  	params.require(:course).permit(:number, :name, :description)
	  end

end