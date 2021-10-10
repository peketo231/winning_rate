require 'rails_helper'

RSpec.describe BattleRecord, type: :model do
  describe 'バリデーション確認' do
    it 'Ratingがあれば有効である' do
      battle_record = build(:battle_record)
      expect(battle_record).to be_valid
    end

    it 'Ratingが数値でない場合無効である' do
      battle_record = build(:battle_record, rate: 'abc')
      battle_record.valid?
      expect(battle_record.errors.of_kind?(:rate, :not_a_number)).to be_truthy
    end

    it 'Ratingが整数でない場合無効である' do
      battle_record = build(:battle_record, rate: '400.0')
      battle_record.valid?
      expect(battle_record.errors.of_kind?(:rate, :not_an_integer)).to be_truthy
    end

    it 'Ratingが0以上でない場合無効である' do
      battle_record = build(:battle_record, rate: '-1')
      battle_record.valid?
      expect(battle_record.errors.of_kind?(:rate, :greater_than_or_equal_to)).to be_truthy
    end

    it 'Ratingが9999以下でない場合無効である' do
      battle_record = build(:battle_record, rate: '10000')
      battle_record.valid?
      expect(battle_record.errors.of_kind?(:rate, :less_than_or_equal_to)).to be_truthy
    end

    it '勝率が数値でない場合無効である' do
      battle_record = build(:battle_record, win_rate: 'abc')
      battle_record.valid?
      expect(battle_record.errors.of_kind?(:win_rate, :not_a_number)).to be_truthy
    end

    it '勝率が0以上でない場合無効である' do
      battle_record = build(:battle_record, win_rate: '-1')
      battle_record.valid?
      expect(battle_record.errors.of_kind?(:win_rate, :greater_than_or_equal_to)).to be_truthy
    end

    it '勝率が100以下でない場合無効である' do
      battle_record = build(:battle_record, win_rate: '101')
      battle_record.valid?
      expect(battle_record.errors.of_kind?(:win_rate, :less_than_or_equal_to)).to be_truthy
    end

    it '不正な勝率の場合無効である' do
      battle_record = build(:battle_record, win_rate: '50.01')
      battle_record.valid?
      expect(battle_record.errors.of_kind?(:win_rate, :invalid)).to be_truthy
    end
  end
end
