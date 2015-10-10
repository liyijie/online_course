module Admin
  class ManagersController < ApplicationController
    load_and_authorize_resource
  	before_action :set_manager, only: [:show, :edit, :update, :destroy]
    def index
      @managers = Manager.page(params[:page]).per(15).keyword(params[:keyword])
    end

    def new
      @manager = Manager.new
    end

    def create
      @manager = Manager.new(manager_params)
      @manager.manager_courses << ManagerCourse.new(course_id: params[:manager][:course_ids],
                                course_id: @manager.id)
      if @manager.save
        flash.now[:notice] = "创建成功"
        return redirect_to admin_managers_url
      else
        return render :new
      end
    end

    def edit
      session[:return_to] ||= request.referer
    end

    def update
      params[:manager][:course_ids] ||= []
      if @manager.update(manager_params)
        flash.now[:notice] = "更新成功"
        redirect_to session.delete(:return_to)
      else
        return render :edit
      end
    end

    def destroy
      @manager.destroy
      return redirect_to admin_managers_url
    end

    def show
    end

    private

    def manager_params
      params.require(:manager).permit(:email, :password, :password_confirmation, :number, :name, :roles, {course_ids: []})
    end
    def set_manager
      @manager = Manager.find(params[:id])
    end
  end
end