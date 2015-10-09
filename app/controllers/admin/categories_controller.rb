module Admin
	class CategoriesController < ApplicationController
		load_and_authorize_resource
		before_action :set_category, only: [:update, :edit, :destroy]
		def index
			@categories = Category.where(deleted_at: nil).page(params[:page]).per(10)
		end

		def new
			@category = Category.new
		end

		def create
			@category = Category.new(category_params)
			if @category.save
				flash.now[:notice] = "创建成功"
				return redirect_to admin_categories_path
			else
				return render :new
			end
		end

		def edit
			session[:return_to] ||= request.referer
		end

		def update
			if @category.update(category_params)
				flash.now[:notice] = "更新成功"
				redirect_to session.delete(:return_to)
			else
				return render :update
			end
		end

		def destroy
			@category.soft_destroy
			return redirect_to admin_categories_path
		end

		private
			def category_params
				params.require(:category).permit(:name)
			end
			def set_category
				@category = Category.find(params[:id])
			end
	end
end