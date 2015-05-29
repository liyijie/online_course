class Admin::TeachersController < ApplicationController
  def index
    @teachers = Teacher.all.page(params[:page])
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
      flash.now[:notice] = "课程创建成功"
      return redirect_to admin_teachers_url
    else
      flash.now[:notice] = "课程创建失败"
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
      flash.now[:notice] = "课程更新成功"
      return redirect_to admin_teachers_url
    else
      flash.now[:notice] = "课程更新失败"
      return :update
    end
  end 

  def show
  end 

  private

    def teacher_params
      params.require(:teacher).permit(:phone, :name, :username, :academy_id, {grade_ids: []}, 
        :final_degree, :final_education, :qualification, :tec_expertise, :password, :password_confirmation)
    end
end
