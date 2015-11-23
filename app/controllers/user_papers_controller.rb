class UserPapersController < ApplicationController
  before_action :authenticate_teacher!, except: :detail
  before_action :authenticate_user!, only: :detail

  def index
    @paper = Paper.where(id: params[:paper_id]).first
    @user_papers = UserPaper.includes(:user).where(users: {grade_id: params[:grade_id]}, user_papers: {paper_id: params[:paper_id]})
    respond_to do |format|
      format.js
    end
  end

  def new
    @paper = Paper.where(id: params[:paper_id]).first
    respond_to do |format|
      format.js
    end
  end 


  def create
    @paper = Paper.where(id: params[:paper_id]).first
    grade = Grade.where(id: params[:grade_id]).first
    grade.users.each do |user|
      UserPaper.create(user_id: user.id, paper_id: @paper.id)
    end
    redirect_to students_paper_path(@paper)
  end

  def detail
    @paper = Paper.includes(:paper_questions).where(id: params[:paper_id]).first
    @user_paper = UserPaper.where(user_id: current_user.id, paper_id: params[:paper_id]).first
  end

  def edit
    @paper = Paper.includes(:paper_questions).where(id: params[:paper_id]).first
    @user_paper = UserPaper.where(id: params[:id]).first
  end

  def update
    @paper = Paper.includes(:paper_questions).where(id: params[:paper_id]).first
    @user_paper = UserPaper.where(id: params[:id]).first
    @user_paper.generate_by_answer_score(params[:scores])
    redirect_to students_paper_path(@paper)
  end


  def destroy_grade
    @paper = Paper.where(id: params[:paper_id]).first
    UserPaper.includes(:user).where(users: {grade_id: params[:grade_id]}, user_papers: {paper_id: params[:paper_id]}).destroy_all
    redirect_to students_paper_path(@paper)
  end

  # 按班级导出成绩
  def export_grade
    @paper = Paper.where(id: params[:paper_id]).first
    grade = Grade.where(id: params[:grade_id]).first
    filename = URI.encode("#{@paper.name}_#{grade.try(:specialty).try(:name)}_#{grade.name}.xls")
    send_data( 
            @paper.export_by_grade(grade),
            type: "text/excel;charset=utf-8; header=present",
            filename: filename
          )
  end
end
