class BattleRecordsController < ApplicationController
  def new
    @battle_record = BattleRecord.new
    render "battle_records/#{params[:name]}"
  end

  def create
    @battle_record = current_user.battle_records.build(battle_record_params)
    @battle_record.save!
    @winning_eleven = @battle_record.winning_eleven
    if @winning_eleven.series_status == 'current'
      @monthly = @battle_record.monthlies.build(monthly_battle_record_params)
      @monthly.month = Date.today.month
      @monthly.save
    end
    redirect_to mypage_path
  end

  private

  def battle_record_params
    params.require(:battle_record).permit(:rate, :win_rate, :winning_eleven_id)
  end

  def monthly_battle_record_params
    params.require(:battle_record).permit(:rate, :win_rate)
  end
end
