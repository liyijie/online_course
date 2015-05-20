class UserController < ApplicationController
  before_action :authenticate_user!  
	
  #我的账户
  def show
  	@user = current_user

  	#学院专业回显赋值
  	@user.academy_id = @user.try(:grade).try(:specialty).try(:academy).try(:id)
  	@user.specialty_id = @user.try(:grade).try(:specialty).try(:id)

    #专业、班级下拉对应值查
  	@specialties = Specialty.where(academy_id: @user.academy_id).pluck(:name, :id)
  	@grades = Grade.where(specialty_id: @user.specialty_id).pluck(:name, :id)
  end


  #个人资料更新
  def update
  	@user = User.where(id: params[:id]).first 

  	#未查找到对应数据时处理
  	if @user.blank?
  	  flash[:error] = "当前个人资料不存在"
  	  edirect_to user_index_path
  	end

    #头像赋值
    if params[:user][:image]
      #头像处理,未上传头像显示默认图片
      @user.image = Image.new if @user.image.blank?
      @user.image.avatar = params[:user][:image] 
    end

  	if @user.update(user_params)

      #头像更新
      @user.image.save(:validate => false)  if params[:user][:image]

  	  #更新成功
  	  #重新登录更新session以及current_user等相关变量方法的值	
  	  sign_in(:user, current_user)

  	  flash[:notice] = "个人资料更新成功"
  	  redirect_to user_index_path
  	else
  	  #更新失败
  	  @specialties = Specialty.where(academy_id: @user.academy_id).pluck(:name, :id)
  	  @grades = Grade.where(specialty_id: @user.specialty_id).pluck(:name, :id)
  	  render :show
  	end

  end


  #我的课程
  def my_courses

  end

  #我的考试
  def my_exams
    
  end

  #成绩查询
  def score_search
    @exams = current_user.try(:exams)
  end

  #我的收藏
  def my_collect

  end

  #我的问答
  def questions_answers

  end

  #讨论中心
  def discuss_center
    @new_comments = Comment.where(commentable_id: nil, parent_id: nil).order("created_at DESC").limit(10)

    @comment = Comment.new
  end


  #讨论中心-发布话题
  def comment_create
    @comment = Comment.new comment_params
    @comment.usertable_id = current_user.id
    @comment.usertable_type = current_user.class
    if @comment.save
      flash[:notice] = "发布话题成功"
      redirect_to discuss_center_user_index_path
    else
      @new_comments = Comment.where(commentable_id: nil, parent_id: nil).order("created_at DESC").limit(10)
      render :discuss_center
    end
  end


  #根据系别的id，查找到该系下所有的专业
  #参数：academy_id,系的id
  def get_specialties
	  @specialties = Specialty.where(academy_id: params[:academy_id]).pluck(:name, :id)
	  respond_to do |format|
      	format.js { "" }
    end
  end

  #根据专业的id，查找到该专业下所有的班级
  #参数：specialty_id,专业的id
  def get_grades
	  @grades = Grade.where(specialty_id: params[:specialty_id]).pluck(:name, :id)
	  respond_to do |format|
      	format.js { "" }
    end
  end


  private
	def user_params
		params.require(:user).permit(:nickname, :name, :number, :position, :academy_id, :specialty_id, :grade_id, 
			:phone, :gender, :signature)
	end

  def comment_params
    params.require(:comment).permit(:title, :body)
  end
end
