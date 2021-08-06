class MonthliesController < ApplicationController
  def index
    @winning_eleven = WinningEleven.find_by(title: params[:label])
    @battle_record = current_user.battle_records.where(winning_eleven_id: @winning_eleven)
    @data = @battle_record.joins(:monthlies)
  end
end
