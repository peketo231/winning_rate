class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_user, only: %i[edit update]

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
    redirect_to root_path, warning: t('defaults.message.logged_in') if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to mypage_path, success: t('.success')
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to mypage_path, success: t('.success')
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
