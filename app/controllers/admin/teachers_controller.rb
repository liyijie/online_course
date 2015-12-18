module Admin
class TeachersController < ApplicationController
  load_and_authorize_resource
  before_action :set_teacher, only: [:edit, :update, :destroy]

  def index
    @teachers = Teacher.page(params[:page]).per(15)
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    @teacher.image = Image.new
    @teacher.image.avatar = params[:teacher][:image]
    @teacher.teacher_grades << TeacherGrade.new(grade_id: params[:teacher][:grade_ids], teacher_id: @teacher.id)
    @teacher.password = "8888"
    @teacher.password_confirmation = "8888"
    if @teacher.save && @teacher.image.save
      flash.now[:notice] = "教师创建成功"
      return redirect_to admin_teachers_url
    else
      p @teacher.errors
      return render :new
    end
  end

  def edit
     session[:return_to] ||= request.referer
  end

  def update
    @teacher.image = Image.new if @teacher.image.blank? && params[:teacher][:image].present?
    params[:teacher][:grade_ids] ||= []
    if @teacher.update(teacher_params)
      @teacher.image.update(avatar: params[:teacher][:image]) if params[:teacher][:image].present?
      flash.now[:notice] = "教师更新成功"
      redirect_to session.delete(:return_to)
    else
      return render action: :update
    end
  end

  def show
  end

  def import
    Teacher.import(params[:file])
    redirect_to admin_teachers_url
  end

  def destroy
    @teacher.destroy
    return redirect_to admin_teachers_url
  end

  private
    def set_teacher
      @teacher = Teacher.where(id: params[:id]).first
    end
    def teacher_params
      params.require(:teacher).permit(:number, :phone, :username, :number, :name, :avatar,
                                    :birthday, :tec_position, :email, :qualification,
                                    :fax, :final_education, :final_degree, :tec_expertise,
                                    :resume, :tec_situation, :tec_service, :deleted_at,
                                    :sex, :grade_id, :signature, {grade_ids: []}, 
                                    :academy_id, :password, :password_confirmation)
    end
end
end
