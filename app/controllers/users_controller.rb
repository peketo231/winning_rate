class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_user, only: %i[edit update]

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

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to battle_records_path, success: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, success: t('.success')
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
