class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    if current_teacher.present?
      flash[:notice] = "您已登录了教师的账号，请先退出再切换登录用户。"
      redirect_to root_path
    else
      super
    end
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end

  def after_sign_in_path_for(resource)
    if params[:c] == "weixin"
      wechat_root_path
    else
      super
    end
  end

  def after_sign_out_path_for(resource)
    if params[:c] == "weixin"
      new_session_path(:user, c: :weixin)
    else
      super
    end
  end
end
