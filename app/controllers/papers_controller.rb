class PapersController < ApplicationController
  before_action :authenticate_user_or_teacher, only: :index
  before_action :authenticate_teacher!, except: :index

  def index
    if params[:type] == 'ing'
      @papers = (current_user || current_teacher).papers.after(Date.today, field: "end_at").before(Date.today, field: "start_at") 
    elsif params[:type] == 'end'
      @papers = (current_user || current_teacher).papers.before(Date.today - 1, field: "end_at") 
    else
      @papers = (current_user || current_teacher).papers.after(Date.today + 1, field: "start_at")  
    end
  end

  def new
    @paper = Paper.new
  end 

  def create
    @paper = Paper.new paper_params
    @paper.teacher_id = current_teacher.id
    if @paper.save
      redirect_to papers_path
    else
      render :new
    end
  end

  def edit
    @paper = Paper.where(id: params[:id]).first
  end

  def update
    @paper = Paper.where(id: params[:id]).first
    if @paper.update(paper_params)
      redirect_to papers_path
    else
      render :edit
    end
  end


  def questions
    @paper = Paper.where(id: params[:id]).first
  end

  def import
    @paper = Paper.where(id: params[:id]).first
    @paper.import(params[:attachment])
    redirect_to questions_paper_path(@paper)
  end

  def students
    @paper = Paper.where(id: params[:id]).first
    @grades = Grade.includes(users: :user_papers).where(user_papers: {paper_id: @paper.id}).distinct
  end

  def destroy
    @paper = Paper.where(id: params[:id]).first
    @paper.destroy if @paper.present?
    redirect_to papers_path
  end

  private

  def paper_params
    params.require(:paper).permit(:course_id, :name, :content, :start_at, :end_at)
  end
end
