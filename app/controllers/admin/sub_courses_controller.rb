module Admin
	class SubCoursesController < ApplicationController
		load_and_authorize_resource
		before_action :set_course
		before_action :set_sub_course, only: [:edit, :update, :destroy, :lower, :higher, :delete, :restore]
		def index
			if params[:status] == "deleted"
			  @sub_courses = @course.sub_courses.bedeleted.page(params[:page]).per(10)
			elsif params[:status] == "undeleted"
				@sub_courses = @course.sub_courses.undeleted.page(params[:page]).per(10)
			else
				@sub_courses = @course.sub_courses.page(params[:page]).per(10)
			end
		end

		def new
			@sub_course = @course.sub_courses.new
			@categories = Category.where(deleted_at: nil)
		end

		def create
			@sub_course = @course.sub_courses.new(sub_course_params)
			@sub_course.position = @sub_course.id
			@sub_course.attachment = Attachment.new if @sub_course.attachment.blank?
			@sub_course.attachment.content = params[:sub_course][:attachment] if params[:sub_course][:attachment].present?
			@sub_course.attachment.file_url = params[:attachment_file_url] if params[:attachment_file_url].present?
			if @sub_course.save && @sub_course.attachment.save
				flash.now[:notice] = "课程创建成功"
				return redirect_to admin_course_sub_courses_path(@course)
			else
				flash.now[:notice] = "课程创建失败"
				return redirect_to admin_course_sub_courses_path(@course)
			end
		end

		def edit
			@categories = Category.where(deleted_at: nil)
			session[:return_to] ||= request.referer
		end

		def update
			@sub_course.attachment = Attachment.new if @sub_course.attachment.blank?
			@sub_course.position = @sub_course.id
			if @sub_course.update(sub_course_params)
				if @sub_course.attachment.present?
					@sub_course.attachment.update(file_url: params[:attachment_file_url])
					@sub_course.attachment.update(content: params[:sub_course][:attachment]) if params[:sub_course][:attachment].present?
				else
					@sub_course.attachment = Attachment.new
					@sub_course.attachment.update(file_url: params[:attachment_file_url])
					@sub_course.attachment.update(content: params[:sub_course][:attachment]) if params[:sub_course][:attachment].present?
				end
				flash.now[:notice] = "课程更新成功"
				redirect_to session.delete(:return_to)
			else
				flash.now[:notice] = "课程更新失败"
				redirect_to session.delete(:return_to)
			end
		end

		def delete
      @sub_course.update(deleted_at: Time.now)
      flash[:notice] = '删除成功'
      redirect_to admin_course_sub_courses_path(@course)
    end

    def restore
      @sub_course.update(deleted_at: nil)
      flash[:notice] = '恢复成功'
      redirect_to admin_course_sub_courses_path(@course)
    end

    #移动对象位置
    def higher
			if @sub_course.position > @course.sub_courses.pluck(:id).max
				return render js: "alert('该项目已经在最顶部!')"
			end
			@sub_course.update(position: @sub_course.position + 1)
			return render js: "window.location.href = '#{admin_course_sub_courses_path(@course)}';"
		end

		def lower
			if @sub_course.position <= @course.sub_courses.pluck(:id).min
				return render js: "alert('该项目已经在最底部!')"
			end
			@sub_course.update(position: @sub_course.position - 1)
			return render js: "window.location.href = '#{admin_course_sub_courses_path(@course)}';"
		end

		private

		def set_course
			@course = Course.find(params[:course_id])
		end

		def sub_course_params
			params.require(:sub_course).permit(:name, :number, :category_id, :tag)
		end

		def set_sub_course
			@sub_course = @course.sub_courses.find(params[:id])
		end
	end
end