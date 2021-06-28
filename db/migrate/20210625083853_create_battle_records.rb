class CreateBattleRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :battle_records do |t|
      t.integer :rate, null:false
      t.float :win_rate
      t.references :user, null: false, foreign_key: true
      t.references :winning_eleven, null: false, foreign_key: true

      t.timestamps
    end
  end
end
