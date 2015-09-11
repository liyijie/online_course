class PapersController < ApplicationController
  before_action :authenticate_user_or_teacher

  def index
    @papers = (current_user || current_teacher).papers
  end

  def new
    @paper = Paper.new
  end 
end
