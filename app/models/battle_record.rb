class BattleRecord < ApplicationRecord
  belongs_to :user
  belongs_to :winning_eleven

  validates :rate, numericality: { less_than_or_equal_to: 9999 }
  validates :win_rate, numericality: { less_than_or_equal_to: 100 }, allow_blank: true, format: { with: /\A[0-9]+\.[0-9]\z/ }
end
