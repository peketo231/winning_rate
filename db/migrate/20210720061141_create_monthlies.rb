class CreateMonthlies < ActiveRecord::Migration[6.0]
  def change
    create_table :monthlies do |t|
      t.integer :month, null: false
      t.integer :rate, null: false
      t.float :win_rate
      t.references :battle_record, null: false, foreign_key: true

      t.timestamps
    end
  end
end
