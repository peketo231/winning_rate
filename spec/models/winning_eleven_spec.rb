require 'rails_helper'

RSpec.describe WinningEleven, type: :model do
  describe 'バリデーション確認' do
    it 'ステータス、タイトルがあれば有効である' do
      winning_eleven = build(:winning_eleven)
      expect(winning_eleven).to be_valid
    end

    it 'ステータスがない場合無効である' do
      winning_eleven = build(:winning_eleven, series_status: nil)
      winning_eleven.valid?
      expect(winning_eleven.errors.of_kind?(:series_status, :blank)).to be_truthy
    end

    it 'タイトルがない場合無効である' do
      winning_eleven = build(:winning_eleven, title: nil)
      winning_eleven.valid?
      expect(winning_eleven.errors.of_kind?(:title, :blank)).to be_truthy
    end

    it '重複したタイトルの場合無効である' do
      create(:winning_eleven)
      winning_eleven = build(:winning_eleven, title: 'ウイニングイレブン2021')
      winning_eleven.valid?
      expect(winning_eleven.errors.of_kind?(:title, :taken)).to be_truthy
    end
  end
end
