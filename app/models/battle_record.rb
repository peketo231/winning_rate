class BattleRecord < ApplicationRecord
  belongs_to :user
  belongs_to :winning_eleven

  validates :rate, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 9999 }
  validates :win_rate, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true, format: { with: /\A[0-9]+\.[0-9]\z/ }
end
