class UserPapersController < ApplicationController
  before_action :authenticate_teacher!

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

end
