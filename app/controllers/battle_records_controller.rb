class BattleRecordsController < ApplicationController
  def index
    @winning_elevens = WinningEleven.where(series_status: 'past').order(:title)
    @battle_records = @winning_elevens.map { |winning_eleven| current_user.battle_records.where(winning_eleven_id: winning_eleven).order(created_at: :desc).limit(1) }.flatten
  end

  def new
    @battle_record = BattleRecord.new
    render "battle_records/#{params[:name]}"
  end

  def create
    @battle_record = current_user.battle_records.build(battle_record_params)
    if @battle_record.save
      @winning_eleven = @battle_record.winning_eleven
      if @winning_eleven.series_status == 'current'
        @monthly = @battle_record.monthlies.build(monthly_battle_record_params)
        @monthly.month = Date.today.month
        @monthly.save
      end
      redirect_to mypage_path
    else
      render "battle_records/#{@battle_record.name}"
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
    params.require(:battle_record).permit(:rate, :win_rate, :winning_eleven_id, :name)
  end

  def monthly_battle_record_params
    params.require(:battle_record).permit(:rate, :win_rate)
  end
end
