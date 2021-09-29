class BattleRecordsController < ApplicationController
  def new
    @battle_record = BattleRecord.new
    render "battle_records/#{params[:name]}"
  end

  def create
    @battle_record = current_user.battle_records.build(battle_record_params)
    @winning_eleven = @battle_record.winning_eleven
    if @battle_record.save
      if @winning_eleven.series_status == 'current'
        @monthly = @battle_record.monthlies.build(monthly_battle_record_params)
        @monthly.month = Date.today.month
        @monthly.save
      end
      redirect_to mypage_path, success: t('.success')
    else
      render "battle_records/#{@winning_eleven.series_status}"
    end
  end

  def destroy
    @battle_record = BattleRecord.find(params[:id])
    @battle_record = current_user.battle_records.where(winning_eleven_id: @battle_record.winning_eleven_id)
    @battle_record.destroy_all
    redirect_to battle_records_path
  end

  private

  def battle_record_params
    params.require(:battle_record).permit(:rate, :win_rate, :winning_eleven_id)
  end

  def monthly_battle_record_params
    params.require(:battle_record).permit(:rate, :win_rate)
  end
end
