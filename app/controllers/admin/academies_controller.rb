module Admin
  class AcademiesController < ApplicationController
    load_and_authorize_resource
    before_action :set_academy, only: [:edit, :update, :destroy]
    def index
      @academies = Academy.page(params[:page]).per(10)
    end

    def new
      @academy = Academy.new
    end

    def create
      @academy = Academy.new(academy_params)
      @academy.school_id = 1
      if @academy.save
        flash.now[:notice] = "创建成功"
        return redirect_to admin_academies_url
      else
        return render :new
      end
    end

    def edit
      session[:return_to] ||= request.referer
    end

    def update
      if @academy.update(academy_params)
        flash.now[:notice] = "更新成功"
        redirect_to session.delete(:return_to)
      else
        return :update
      end
    end

    def destroy
      @academy.destroy
      return redirect_to admin_academies_url
    end

    def show
    end

    private

    def academy_params
      params.require(:academy).permit(:name, :school_id, :academy_code)
    end
    def set_academy
      @academy = Academy.find(params[:id])
    end
  end
end