class BattleRecord < ApplicationRecord
  belongs_to :user
  belongs_to :winning_eleven
  has_many :monthlies, dependent: :destroy

  validates :rate, numericality: { less_than_or_equal_to: 9999 }
  validates :win_rate, numericality: { less_than_or_equal_to: 100 }, allow_blank: true, format: { with: /\A[0-9]+\.[0-9]\z/ }

  with_options uniqueness: { scope: :winning_eleven_id }, if: :past? do
    validates :rate
    validates :win_rate
  end

  def past?
    return unless winning_eleven_id.present?

    winning_eleven.series_status == 'past'
  end
end
