require 'rails_helper'

RSpec.describe 'UserSessions', type: :system do
    let(:user) { create(:user) }

    describe 'ログイン' do
        it 'ログインが成功する' do
            visit login_path
            fill_in 'メールアドレス', with: user.email
            fill_in 'パスワード', with: 'password'
            click_button 'ログイン'
            expect(page).to have_content 'ログインしました'
            expect(current_path).to eq battle_records_path
        end

        it 'ログインが失敗する' do
            visit login_path
            fill_in 'メールアドレス', with: ''
            fill_in 'パスワード', with: 'password'
            click_button 'ログイン'
            expect(page).to have_content 'メールアドレスまたはパスワードが違います'
            expect(current_path).to eq login_path
        end
    end

    describe 'ログアウト' do
        it 'ログアウトが成功する' do
            login_as(user)
            click_link 'ログアウト'
            expect(page).to have_content 'ログアウトしました'
            expect(current_path).to eq root_path
        end
    end
end