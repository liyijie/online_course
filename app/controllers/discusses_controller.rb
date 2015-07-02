class DiscussesController < ApplicationController
  before_action :authenticate_user_or_teacher, only: [:new, :create]

  def index
    @academies = Academy.all
  end

  def show
  end

  def new
  end

  def create
  end
end
