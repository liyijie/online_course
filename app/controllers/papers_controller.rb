class PapersController < ApplicationController
  before_action :authenticate_user_or_teacher

  def index
    @papers = (current_user || current_teacher).papers
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

  private

  def paper_params
    params.require(:paper).permit(:course_id, :name, :content, :start_at, :end_at)
  end
end
