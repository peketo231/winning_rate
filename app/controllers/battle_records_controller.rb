class BattleRecordsController < ApplicationController
  def index
    @battle_record = current_user.battle_records
    @title = @battle_record.joins(:winning_eleven).order(:title).distinct.pluck(:title)
    @winning_eleven = WinningEleven.find_by(title: @title)
  end

  def new
    @battle_record = BattleRecord.new
  end

  def create
    @battle_record = current_user.battle_records.build(battle_record_params)
    @battle_record.month = Date.today.month
    if @battle_record.save
      redirect_to battle_records_path, success: t('.success')
    else
      render :new
    end
  end

  def monthly
    @winning_eleven = WinningEleven.find_by('title like ?', "%#{params[:label]}%")
    @battle_record = current_user.battle_records.where(winning_eleven_id: @winning_eleven)
    @month = @battle_record.distinct.pluck(:month)
  end

  private

  def battle_record_params
    params.require(:battle_record).permit(:rate, :win_rate, :winning_eleven_id)
  end
end
