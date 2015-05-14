class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :get_layout

  

  # layout全局设置
  #【引数】
  #【返値】
  #【注意】
  #【著作】2015/05/7 by fw
  def get_layout
    if devise_controller?
    	'login'
    end
  end




  protected

  def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:phone, :password, :password_confirmation) }
  end



end
