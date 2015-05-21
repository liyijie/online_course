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
	private
	  def course_params
	  	params.require(:course).permit(:number, :name, :description)
	  end
end