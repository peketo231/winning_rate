class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def show
    @battle_record = current_user.battle_records.joins(:winning_eleven)
    @data = @battle_record.order(:title).distinct.pluck(:title)
    @rate = @data.map do |d|
      @winning_eleven = WinningEleven.find_by(title: d)
      @battle_record.where(winning_eleven_id: @winning_eleven).order(created_at: :desc).limit(1).pluck(:rate)
    end
    @win_rate = @data.map do |d|
      @winning_eleven = WinningEleven.find_by(title: d)
      @battle_record.where(winning_eleven_id: @winning_eleven).order(created_at: :desc).limit(1).pluck(:win_rate)
    end
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
