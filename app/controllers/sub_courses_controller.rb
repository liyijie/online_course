class SubCoursesController < ApplicationController
  before_action :authenticate_user_or_teacher, only: [:comment_create_list, :reply_comment_list], if: "params[:comment].present?"
  before_action :authenticate_user_or_teacher2, only: :comment_praise
  before_action :authenticate_user , only: [:collect_or_praise] , if: "!teacher_signed_in?"

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

  def new
    @sub_course = SubCourse.new
    @courses = Course.joins(:teacher_courses).where(teacher_courses: {teacher_id: current_teacher.id})
  end

  def create
    @sub_course = SubCourse.new(sub_course_params)
    @sub_course.attachment = Attachment.new if @sub_course.attachment.blank?
    @sub_course.attachment.content = params[:sub_course][:attachment]
    if @sub_course.save && @sub_course.attachment.save
      flash.now[:notice] = "创建成功"
      return render js: "window.location.href='#{my_courses_teachers_url}'"
    else
      flash.now[:notice] = "创建失败"
      return render js: "window.location.href='#{my_courses_teachers_url}'"
    end
  end

  def edit
    @sub_course = SubCourse.find(params[:id])
    @courses = Course.joins(:teacher_courses).where(teacher_courses: {teacher_id: current_teacher.id})
  end

  def update
    @sub_course = SubCourse.find(params[:id])
    if @sub_course.update(sub_course_params)
      flash.now[:notice] = "更新成功"
      return render js: "window.location.href='#{my_courses_teachers_url}'"
    else
      flash.now[:notice] = "更新失败"
      return render js: "window.location.href='#{my_courses_teachers_url}'"
    end
  end

  def destroy
    @sub_course = SubCourse.find(params[:id])
    @sub_course.destroy
    return redirect_to my_courses_teachers_url
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


  #收藏或者喜欢
  def collect_or_praise
    if current_user.present?
      @success, @like = SubCourse.collect_or_praise current_user, params[:scope], params[:sub_course_id]
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js {render js: "alert('学生登录才可以操作');"}
      end
    end
  end 

  private
  def sub_course_params
    params.require(:sub_course).permit(:name, :course_id)
  end
end