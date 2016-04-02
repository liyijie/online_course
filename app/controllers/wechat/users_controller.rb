class Wechat::UsersController < Wechat::BaseController
  def show
    @user = current_user
    @numbers = User.quantities(@user)
  end
end
