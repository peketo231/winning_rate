class AddIndexTitleToWinningElevens < ActiveRecord::Migration[6.0]
  def change
    add_index :winning_elevens, :title, unique: true
  end
end
