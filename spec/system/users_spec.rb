require 'rails_helper'

RSpec.describe 'Users', type: :system do
    describe 'ユーザー新規登録' do
        it 'ユーザーの新規登録が成功する' do
            visit new_user_path
            fill_in 'メールアドレス', with: 'email@example.com'
            fill_in 'パスワード', with: 'password'
            fill_in 'パスワード確認', with: 'password'
            click_button '登録'
            expect(page).to have_content '登録が完了しました'
            expect(current_path).to eq battle_records_path
        end

        it 'ユーザーの新規登録が失敗する' do
            visit new_user_path
            fill_in 'メールアドレス', with: ''
            fill_in 'パスワード', with: 'password'
            fill_in 'パスワード確認', with: 'password'
            click_button '登録'
            expect(page).to have_content 'メールアドレスを入力してください'
            expect(current_path).to eq users_path
        end
    end
end