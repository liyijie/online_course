module Admin
	class CoursesController < ApplicationController
		before_action :set_course, only: [:edit, :update, :destroy]
		def index
			@courses = Course.page(params[:page]).per(10)
		end

		def new
			@course = Course.new
		end

		def create
			@course = Course.new(course_params)
			@course.image = Image.new
			@course.image.avatar = params[:course][:image]
			@course.teacher_courses << TeacherCourse.new(teacher_id: params[:course][:teacher_ids],
				                        course_id: @course.id)
			if @course.save && @course.image.save
				flash.now[:notice] = "课程创建成功"
				return redirect_to admin_courses_url
			else
				flash.now[:notice] = "课程创建失败"
				return redirect_to admin_courses_url
			end
		end

		def edit
		end

		def update
			@course.image = Image.new if @course.image.blank?
			params[:course][:teacher_ids] ||= []
			if @course.update(course_params) && @course.image.update(avatar: params[:course][:image])
				flash.now[:notice] = "课程更新成功"
				redirect_to admin_courses_url
			else
				flash.now[:notice] = "课程更新失败"
				redirect_to admin_courses_url
			end
		end

		def destroy
		end

		private

		def course_params
			params.require(:course).permit(:name, :description, :academy_id, {teacher_ids: []})
		end

		def set_course
			@course = Course.find(params[:id])
		end
	end
end