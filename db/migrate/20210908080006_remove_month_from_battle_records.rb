class RemoveMonthFromBattleRecords < ActiveRecord::Migration[6.0]
  def change
    remove_column :battle_records, :month, :integer
  end
end
