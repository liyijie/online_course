class LoginBaseController < ApplicationController
  before_action :authenticate_user!  
  #authorize_resource :class => false

  #捕捉权限异常
  # rescue_from CanCan::AccessDenied do |e|
  #   flash[:error] = I18n.t(:no_premission)
  #   session = nil
  #   redirect_to root_url
  # end

end