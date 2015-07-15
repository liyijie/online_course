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
			@course.image = Image.new if @course.image.blank?
			@course.attachment.content = params[:course][:attachment]
			@course.image.avatar = params[:course][:image]
			@course.attachment.file_url = params[:attachment_file_url]
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
			@course.attachment = Attachment.new if @course.attachment.blank? && params[:course][:attachment].present?
			@course.image = Image.new if @course.image.blank? && params[:course][:image].present?
			params[:course][:teacher_ids] ||= []
			if @course.update(course_params)
				@course.attachment.update(content: params[:course][:attachment]) if params[:course][:attachment].present?
				@course.image.update(avatar: params[:course][:image]) if params[:course][:image].present?
				if @course.attachment.present?
				  @course.attachment.update(file_url: params[:attachment_file_url]) if params[:attachment_file_url].present?
				else
					@course.attachment = Attachment.new
					@course.attachment.create(file_url: params[:attachment_file_url]) if params[:attachment_file_url].present?
				end
				flash.now[:notice] = "课程更新成功"
				return redirect_to admin_courses_url
			else
				flash.now[:notice] = "课程更新失败"
				return render action: :edit
			end
		end

		def destroy
      @course.destroy
      return redirect_to admin_courses_url
    end

		private

		def course_params
			params.require(:course).permit(:name, :description, :excellented, :academy_id, {teacher_ids: []})
		end

		def set_course
			@course = Course.find(params[:id])
		end
	end
end