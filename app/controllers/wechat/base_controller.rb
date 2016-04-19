class Wechat::BaseController < ApplicationController
  layout "wechat"
  before_action :is_login!
  before_action :weixin_global

  private 

  def is_login!
    unless user_signed_in?
      redirect_to new_session_path(:user, c: :weixin)
    end
  end

  def weixin_global
    unless $client.try(:is_valid?)
      $client ||= WeixinAuthorize::Client.new(WeixinRailsMiddleware.config.app_id, WeixinRailsMiddleware.config.weixin_secret_string)
      # $client ||= WeixinAuthorize::Client.new(ENV["APPID"], ENV["APPSECRET"])
    end
  end
end
