class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!  

  layout :get_layout

  # 捕捉权限异常
  rescue_from CanCan::AccessDenied do |e|
    flash[:error] = I18n.t(:no_premission)
    session = nil
    redirect_to new_session_path(:user)
  end


  # layout全局设置
  #【引数】
  #【返値】
  #【注意】
  #【著作】2015/05/7 by fw
  def get_layout
    if params[:controller].match /^devise\//
    	'login'
    end
  end


end
