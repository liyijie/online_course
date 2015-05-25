module Admin
	class SubCoursesController < ApplicationController
    before_action :set_course
		before_action :set_sub_course, only: [:edit, :update, :destroy]
		def index
			@sub_courses = @course.sub_courses.page(params[:page]).per(10)
		end

		def new
			@sub_course = @course.sub_courses.new
		end

		def create
			@sub_course = @course.sub_courses.new(sub_course_params)
			@sub_course.attachment = Attachment.new if @sub_course.attachment.blank?
			@sub_course.attachment.content = params[:sub_course][:attachment]
			if @sub_course.save && @sub_course.attachment.save
				flash.now[:notice] = "课程创建成功"
				return redirect_to admin_course_sub_courses_path(@course)
			else
				flash.now[:notice] = "课程创建失败"
				return redirect_to admin_course_sub_courses_path(@course)
			end
		end

		def edit
		end

		def update
			@sub_course.attachment = Attachment.new if @sub_course.attachment.blank?
			if @sub_course.update(sub_course_params) && @sub_course.attachment.update(content: params[:sub_course][:attachment])
				flash.now[:notice] = "课程更新成功"
				redirect_to admin_course_sub_courses_path(@course)
			else
				flash.now[:notice] = "课程更新失败"
				redirect_to admin_course_sub_courses_path(@course)
			end
		end

		def destroy
		end

		private

		def set_course
			@course = Course.find(params[:course_id])
		end

		def sub_course_params
			params.require(:sub_course).permit(:name, :number)
		end

		def set_sub_course
			@sub_course = @course.sub_courses.find(params[:id])
		end
	end
end