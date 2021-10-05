class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :battle_records, dependent: :destroy
  has_many :winning_elevens, through: :battle_records

  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  validates :email, presence: true

  enum role: { general: 0, admin: 1 }
end
