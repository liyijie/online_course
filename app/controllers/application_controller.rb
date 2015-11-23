class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :is_login!, if: :devise_controller? 
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
    if devise_controller? && params[:controller] != "users/registrations"
      'login'
    elsif is_admin?
      'admin'
    end
  end

  def authenticate_user
    if request.xhr?
      if !user_signed_in?
        respond_to do |format|
          format.js { render js: "parent.location.href='#{new_user_session_path}'" }
        end
      end
    else
      super
    end
  end

  def authenticate_user_or_teacher
    if !user_signed_in? and !teacher_signed_in?
      if request.xhr?
        respond_to do |format|
          format.js { render js: "parent.location.href='#{new_user_session_path}'" }
        end
      else 
        authenticate_user!
      end 
    end 
  end 

  def authenticate_user_or_teacher2
    authenticate_user_or_teacher
  end


  protected

  #是否后台页面
  def is_admin?
    params[:controller].split("/").first=="admin"
  end

  def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:phone, :password, :password_confirmation) }
  end

 #登录后不能再进入登录页面
  def is_login!
    if (user_signed_in? || teacher_signed_in?) && params[:action] == "sign_in"
      flash[:error] = "你已经登录系统，不能重复登录"
      if request.xhr?
        respond_to do |format|
          format.js { render js: "parent.location.href='#{new_user_session_path}'" }
        end
      else
        redirect_to root_url
      end
    end
  end


end
