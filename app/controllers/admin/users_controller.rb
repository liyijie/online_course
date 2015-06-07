class Admin::UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page])
  end

  def new
    @user = User.new
    @specialties = []
    @grades = []
  end

  def create
    @user = User.new(user_params)
    @user.image = Image.new
    @user.image.avatar = params[:user][:image]
    if @user.save && @user.image.save
      flash.now[:notice] = "用户创建成功"
      return redirect_to admin_users_url
    else
      return render :new
    end
  end

  def import
    User.import(params[:file])
    redirect_to admin_users_url
  end


  def edit
    @user = User.where(id: params[:id]).first
    #学院专业回显赋值
    @user.academy_id = @user.try(:grade).try(:specialty).try(:academy).try(:id)
    @user.specialty_id = @user.try(:grade).try(:specialty).try(:id)

    #专业、班级下拉对应值查
    @specialties = Specialty.where(academy_id: @user.academy_id).pluck(:name, :id)
    @grades = Grade.where(specialty_id: @user.specialty_id).pluck(:name, :id)
  end

  def update
    @user = User.where(id: params[:id]).first
    @user.image = Image.new if @user.image.blank?
    if @user.update(user_params) && @user.image.update(avatar: params[:user][:image])
      flash.now[:notice] = "用户更新成功"
      return redirect_to admin_users_url
    else
      #专业、班级下拉对应值查
      @specialties = Specialty.where(academy_id: @user.academy_id).pluck(:name, :id)
      @grades = Grade.where(specialty_id: @user.specialty_id).pluck(:name, :id)
      return :update
    end
  end

  #模板下载
  def download
  end

   private

    def user_params
      params.require(:user).permit(:campus, :phone, :nickname,:name, :username, :grade_id,
        :number, :position, :gender, :signature, :password, :password_confirmation)
    end
end
