class AddMonthToBattleRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :battle_records, :month, :integer, null: false
  end
end
