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
			@course.attachment = Attachment.new if @course.attachment.blank?
			@course.attachment.content = params[:course][:attachment]
			@course.teacher_courses << TeacherCourse.new(teacher_id: params[:course][:teacher_ids],
				                        course_id: @course.id)
			if @course.save && @course.attachment.save
				flash.now[:notice] = "课程创建成功"
				return redirect_to admin_courses_url
			else
				flash.now[:notice] = "课程创建失败"
				return render action: :new
			end
		end

		def edit
		end

		def update
			@course.attachment = Attachment.new if @course.attachment.blank?
			params[:course][:teacher_ids] ||= []
			if @course.update(course_params) && @course.attachment.update(content: params[:course][:attachment])
				flash.now[:notice] = "课程更新成功"
				return redirect_to admin_courses_url
			else
				flash.now[:notice] = "课程更新失败"
				return render action: :edit
			end
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