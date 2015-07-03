class Admin::TeachersController < ApplicationController
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
    @teacher.teacher_grades << TeacherGrade.new(grade_id: params[:teacher][:grade_ids],
                              teacher_id: @teacher.id)
    if @teacher.save && @teacher.image.save
      flash.now[:notice] = "教师创建成功"
      return redirect_to admin_teachers_url
    else
      return render :new
    end
  end

  def edit
    @teacher = Teacher.where(id: params[:id]).first
  end

  def update
    @teacher = Teacher.where(id: params[:id]).first
    @teacher.image = Image.new if @teacher.image.blank?
    params[:teacher][:grade_ids] ||= []
    if @teacher.update(teacher_params) && @teacher.image.update(avatar: params[:teacher][:image])
      flash.now[:notice] = "教师更新成功"
      return redirect_to admin_teachers_url
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

  private

    def teacher_params
      params.require(:teacher).permit(:number, :phone, :username, :number, :name, :avatar,
                                    :birthday, :tec_position, :email, :qualification,
                                    :fax, :final_education, :final_degree, :tec_expertise,
                                    :resume, :tec_situation, :tec_service, :deleted_at,
                                    :sex, :grade_id, :signature, {grade_ids: []}, 
                                    :academy_id, :password, :password_confirmation)
    end
end
