class CreateWinningElevens < ActiveRecord::Migration[6.0]
  def change
    create_table :winning_elevens do |t|
      t.integer :series_status, default: 0, null: false
      t.string :title, null: false

      t.timestamps
    end
  end
end
