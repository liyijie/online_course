module Admin
	class ApplicationController < ActionController::Base
	  # Prevent CSRF attacks by raising an exception.
	  # For APIs, you may want to use :null_session instead.
	  protect_from_forgery with: :exception
	  before_filter :authenticate_manager!
	  layout 'admin'

    private
	  # 将会将CanCan通过current_manager获取当前登录用户
    def current_ability
      if current_manager.present?
        @current_ability ||= Ability.new(current_manager)
      end
    end
  end
end
