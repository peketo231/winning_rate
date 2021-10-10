require 'rails_helper'

RSpec.describe 'BattleRecords', type: :system do
    let(:user) { create(:user) }
    let!(:winning_eleven) { create(:winning_eleven) }
    before { login_as(user) }

    describe '戦績新規登録' do
        it '戦績の新規登録が成功する' do
            visit new_battle_record_path
            fill_in 'Rating', with: '400'
            click_button '登録'
            expect(page).to have_content '戦績を登録しました'
            expect(current_path).to eq battle_records_path
        end

        it '戦績の新規登録が失敗する' do
            visit new_battle_record_path
            fill_in 'Rating', with: ''
            click_button '登録'
            expect(page).to have_content 'Ratingは数値で入力してください'
            expect(current_path).to eq battle_records_path
        end
    end
end