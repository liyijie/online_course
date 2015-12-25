module Admin
	class CoursesController < ApplicationController
		load_and_authorize_resource
		before_action :set_course, only: [:edit, :update, :destroy, :delete, :restore]
		def index
			#管理员读取所以数据，其他用户读取拥有权限数据
			if current_manager.administer?
			  @courses = Course.page(params[:page]).per(10)
			else
				@courses = current_manager.courses.page(params[:page]).per(10)
			end
			if params[:status] == "deleted"
				if current_manager.administer?
			    @courses = Course.bedeleted.page(params[:page]).per(10)
			  else
			  	@courses = current_manager.courses.bedeleted.page(params[:page]).per(10)
			  end
			elsif params[:status] == "undeleted"
				if current_manager.administer?
				  @courses = Course.undeleted.page(params[:page]).per(10)
				else
					@courses = current_manager.courses.undeleted.page(params[:page]).per(10)
				end
			else
				if current_manager.administer?
				  @courses = Course.page(params[:page]).per(10)
				else
					@courses = current_manager.courses.page(params[:page]).per(10)
				end
			end
		end

		def new
			@course = Course.new
		  @specialties = []
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
			  @specialties = []
				return render action: :new
			end
		end

		def edit
			session[:return_to] ||= request.referer
		  @specialties = Specialty.where(academy_id: @course.academy_id).pluck(:name, :id)
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
				redirect_to session.delete(:return_to)
				#return redirect_to admin_courses_url
			else
				@specialties = Specialty.where(academy_id: @course.academy_id).pluck(:name, :id)
				flash.now[:notice] = "课程更新失败"
				return render action: :edit
			end
		end

    def delete
      @course.update(deleted_at: Time.now)
      flash[:notice] = '删除成功'
      redirect_to admin_courses_path
    end

    def restore
      @course.update(deleted_at: nil)
      flash[:notice] = '恢复成功'
      redirect_to admin_courses_path
    end

		private

		def course_params
			params.require(:course).permit(:name, :description, :college_applied, :city_applied, :applied_date, :manager_id, :academy_id, :specialty_id, {teacher_ids: []})
		end

		def set_course
			@course = Course.find(params[:id])
		end
	end
end