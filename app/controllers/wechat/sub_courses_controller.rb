class Wechat::SubCoursesController < Wechat::BaseController
  def show
    @sub_course = SubCourse.where(number: params[:number]).first
    if @sub_course.blank?
      flash.now[:notice] = "视频不存在"
      redirect_to root_path
      return
    end
    @course = @sub_course.try(:course)
    @partners = @course.get_likes(vote_scope: :collect).page(params[:partner_page])
    @comments = @sub_course.root_comments.where(comment_scope: "discuss").order("created_at DESC").page(params[:page])
    @relate_sub_courses = SubCourse.undeleted.joins(:attachment).where("sub_courses.course_id = ? AND attachments.content_content_type like ?", @course.id, "%video%")
    .order("RAND()").limit(3)
  end

  #课件下载
  def download
    @sub_course = SubCourse.find_by(number: params[:number])

    pp @sub_course.attachment.content.path
    send_file @sub_course.attachment.content.path,
    type: @sub_course.attachment.content.content_type,
    x_sendfile: true
  end

  #视频评论或者发起提问
  def comment_create_list
    user = current_user || current_teacher
    
    #保存发布的评论并返回新的评论列表
    @comments = SubCourse.save_comment_return_comments user,params

    respond_to do |format|
      format.js 
    end
  end


  #回复评论
  def reply_comment_list
    user = current_user || current_teacher
    
    @comments = SubCourse.reply_comment_returns_comments user,params
    # redirect_to show_wechat_sub_courses_path(number: sub_course.number, course_number: @course.number)
    respond_to do |format|
      format.js 
    end
  end

  #评论点赞
  def comment_praise
    user = current_user || current_teacher
    comment = Comment.where(id: params[:comment_id]).first
    if comment.present?
      #评论点赞
      @is_parise = comment.comment_praise user

      respond_to do |format|
        format.js 
      end
    else
      respond_to do |format|
        format.js {render js: "alert('评论不存在');"}
      end
    end
  end

  private
  def sub_course_params
    params.require(:sub_course).permit(:name, :course_id)
    @sub_course = SubCourse.where(number: params[:number]).first
    @course = @sub_course.try(:course)
  end
end