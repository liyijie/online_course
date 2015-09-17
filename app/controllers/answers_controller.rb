class AnswersController < ApplicationController
  before_action :authenticate_user!

  def new
    @paper = Paper.includes(:paper_questions).where(id: params[:paper_id]).first
    @answered = UserPaper.where(user_id: current_user.id, paper_id: params[:paper_id], answered: true).first.present?
  end

  def create
    @paper = Paper.includes(:paper_questions).where(id: params[:paper_id]).first
    user_paper = UserPaper.where(user_id: current_user.id, paper_id: params[:paper_id], answered: false).first
    user_paper.generate_by_answer_params(params[:options]) if user_paper.present?
    flash[:notice] = " 试卷提交成功"
    redirect_to papers_path(type: "ing")
  end

end
