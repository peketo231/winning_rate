class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def show
    @battle_record = current_user.battle_records
    @data = @battle_record.joins(:winning_eleven).order(:title)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
