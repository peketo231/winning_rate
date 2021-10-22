class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
    redirect_to root_path, warning: t('defaults.message.logged_in') if logged_in?
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to battle_records_path, success: t('.success')
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
