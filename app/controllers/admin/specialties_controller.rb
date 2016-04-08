module Admin
  class SpecialtiesController < ApplicationController
    load_and_authorize_resource
    before_action :set_specialty, only: [:edit, :update, :destroy]
    def index
      # 把院系关键词改为academy_id
      cache = params[:keyword].nil? ? nil : params[:keyword].delete(" ")
      academy = Academy.where(name: cache).first
      keyword = academy.present? ? academy.id : cache
      @specialties = Specialty.page(params[:page]).per(10).keyword_like(keyword)
    end

    def new
      @specialty = Specialty.new
    end

    def create
      @specialty = Specialty.new(specialty_params)
      if @specialty.save
        flash.now[:notice] = "创建成功"
        return redirect_to admin_specialties_url
      else
        return render :new
      end
    end

    def edit
      session[:return_to] ||= request.referer
    end

    def update
      if @specialty.update(specialty_params)
        flash.now[:notice] = "更新成功"
        redirect_to session.delete(:return_to)
      else
        return :update
      end
    end

    def destroy
      @specialty.destroy
      return redirect_to admin_specialties_url
    end

    def show
    end

    private

    def specialty_params
      params.require(:specialty).permit(:name, :code, :academy_id)
    end
    def set_specialty
      @specialty = Specialty.find(params[:id])
    end
  end
end