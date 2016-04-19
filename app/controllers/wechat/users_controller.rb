class Wechat::UsersController < Wechat::BaseController
  before_action :set_user, only: [:edit, :update]

  def show
    @user = current_user
    @numbers = User.quantities(@user)
  end

  # 修改密码
  def edit_password
  end

  # 更新密码
  def update_password
    msg = current_user.custom_reset_password params[:user]
    if msg == "修改成功"
      redirect_to wechat_root_path
    else
      flash[:danger] = msg
      redirect_to edit_password_wechat_user_path(current_user)
    end
  end

  #我的考试
  def my_exams
    @numbers = User.quantities(current_user)
    @exams = current_user.try(:exams)
  end

  #我的课程
  def my_courses
    @numbers = User.quantities(current_user)
    @course = Course.where(:academy_id => current_user.academy_id)
    @collect_course = current_user.find_up_voted_items vote_scope: :collect, votable_type: :Course
  end

  def edit
    #学院专业回显赋值
    @user.academy_id = @user.try(:grade).try(:specialty).try(:academy).try(:id)
    @user.specialty_id = @user.try(:grade).try(:specialty).try(:id)

    #专业、班级下拉对应值查
    @specialties = Specialty.where(academy_id: @user.academy_id).pluck(:name, :id)
    @grades = Grade.where(specialty_id: @user.specialty_id).pluck(:name, :id)
  end

  def update
    #头像赋值
    if params[:user][:image]
      #头像处理,未上传头像显示默认图片
      @user.image = Image.new if @user.image.blank?
      @user.image.avatar = params[:user][:image] 
    end

    if @user.update(user_params)
      #头像更新
      @user.image.save(:validate => false)  if params[:user][:image]
      flash.now[:notice] = "个人资料更新成功"
      redirect_to wechat_root_path
    else
      #更新失败
      @specialties = Specialty.where(academy_id: @user.academy_id).pluck(:name, :id)
      @grades = Grade.where(specialty_id: @user.specialty_id).pluck(:name, :id)
      render :edit, notice: "个人资料更新失败"
    end
  end

    #我的问答
  def persion_discusses
    # 我的提问
    @question_comments = Comment.find_root_comments_by_usertable(current_user, :answer).page(params[:page])
    # 我的回答
    @answer_comments = Comment.find_answer_by_usertable(current_user).page(params[:page])
  end

  private 
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:nickname, :name, :position, :academy_id, :specialty_id, :grade_id, :gender, :signature, :phone)
    end
end
