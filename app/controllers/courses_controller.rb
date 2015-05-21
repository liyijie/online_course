class CoursesController < ApplicationController
  	def index
		@courses = Course.all
  	end

	def show
		@course = Course.find_by(number: params[:number])
		@sub_courses = @course.sub_courses
		@sub_courses.each do |sb|
		end
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

	def show
		@course = Course.find_by(number: params[:number])
		@sub_courses = @course.sub_courses
		@sub_courses.each do |sb|
			p "xxxxx"
			p sb.id
		end
  	end


  	#课程的收藏或者取消收藏
  	def course_collect
  		collect_sucess, @collect = Course.course_collect params[:course_id],current_user
  	
  		if collect_sucess
  	  		respond_to do |format|
  	  		format.js {""}
      	end
  		else
  	 		respond_to do |format|
  	  			format.js { render js: "alert('用户登录后才可以收藏');" }
      		end
  		end 
  	end

	private
	  def course_params
	  	params.require(:course).permit(:number, :name, :description)
	  end
end