class BattleRecord < ApplicationRecord
  belongs_to :user
  belongs_to :winning_eleven

  validates :rate, presence: true
end
