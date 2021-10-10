require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション確認' do
    it 'メールアドレス、パスワードがあれば有効である' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'メールアドレスがない場合無効である' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors.of_kind?(:email, :blank)).to be_truthy
    end
    
    it '重複したメールアドレスの場合無効である' do
      create(:user, email: 'email@example.com')
      user = build(:user, email: 'email@example.com')
      user.valid?
      expect(user.errors.of_kind?(:email, :taken)).to be_truthy
    end

    it 'パスワードが8文字以上でない場合無効である' do
      user = build(:user, password: '1234567')
      user.valid?
      expect(user.errors.of_kind?(:password, :too_short)).to be_truthy
    end

    it 'パスワードとパスワード確認が一致しない場合無効である' do
      user = build(:user, password_confirmation: '12345678')
      user.valid?
      expect(user.errors.of_kind?(:password_confirmation, :confirmation)).to be_truthy
    end

    it 'パスワード確認がない場合無効である' do
      user = build(:user, password_confirmation: nil)
      user.valid?
      expect(user.errors.of_kind?(:password_confirmation, :blank)).to be_truthy
    end
  end
end
