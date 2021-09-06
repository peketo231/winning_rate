class MonthliesController < ApplicationController
  def index
    @winning_eleven = WinningEleven.find_by('title like ?', "%#{params[:label]}%")
    @battle_record = current_user.battle_records.where(winning_eleven_id: @winning_eleven)
    @month = Monthly.where(battle_record_id: @battle_record)
    @data = @month.distinct.pluck(:month)
  end
end
