class WinningEleven < ApplicationRecord
  has_many :battle_records, dependent: :destroy
  has_many :users, through: :battle_records

  validates :series_status, presence: true
  validates :title, presence: true

  enum series_status: { past: 0, current: 1 }
end
