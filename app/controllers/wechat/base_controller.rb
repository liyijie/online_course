class Wechat::BaseController < ApplicationController
  layout "wechat"
  before_action :is_login!


  private 

  def is_login!
    unless user_signed_in?
      redirect_to new_session_path(:user, c: :weixin)
    end
  end
end
