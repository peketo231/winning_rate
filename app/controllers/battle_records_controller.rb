class BattleRecordsController < ApplicationController
  def new
    render "battle_records/#{params[:name]}"
  end
end
