class SubCoursesController < ApplicationController
	def show
    @sub_course = SubCourse.where(number: params[:number]).first
    if @sub_course.blank?
      flash[:notice] = "视频不存在"
      redirect_to root_path
      return
    end
    @comments = @sub_course.root_comments.where(comment_scope: "discuss").order("created_at DESC").page(params[:page])
	end

  #课件下载
	def download
		@sub_course = SubCourse.find_by(number: params[:number])
		send_file @sub_course.attachment.content.path,
		          type: @sub_course.attachment.content.content_type,
		          x_sendfile: true
	end


  #视频评论或者发起提问
  def comment_create_list
    user = current_user || current_teacher

    if user.blank? && params[:comment].present?
      #没登录时不能发布评论
      respond_to do |format|
        format.js {render js: "alert('登录后才可以评论');"}
      end
    else
      #保存发布的评论并返回新的评论列表
      @comments = SubCourse.save_comment_return_comments user,params

      respond_to do |format|
        format.js 
      end
    end
  end


  #回复评论
  def reply_comment_list
    user = current_user || current_teacher
    if user.blank?
      respond_to do |format|
        format.js {render js: "alert('登录后才可以评论');"}
      end
    else
      #保存回复的评论并返回新的评论列表
      @comments = SubCourse.reply_comment_returns_comments user,params

      respond_to do |format|
        format.js 
      end
    end
  end
end