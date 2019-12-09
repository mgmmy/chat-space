# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ログイン・サインアップ', type: :feature do
  before do
    visit root_path
  end

  context '未ログイン状態のときに' do
    it '認証画面が表示されること' do
      expect(page).to have_content 'アカウント登録もしくはログインしてください。'
    end

    it 'Sign upボタンが表示されること' do
      expect(page).to have_link 'Sign up'
    end

    it 'Sign upボタンを押下するとアカウント作成画面が表示されること' do
      click_on 'Sign up'
      expect(page).to have_content '新規アカウントの作成'
    end
  end

  context 'アカウント作成画面にアクセスしたときに' do
    before do
      click_on 'Sign up'
    end

    it '名前のフィールドが表示されること' do
      expect(page).to have_field 'Name'
    end

    it 'メールのフィールドが表示されること' do
      expect(page).to have_field 'Email'
    end

    it 'パスワードのフィールドが表示されること' do
      expect(page).to have_field 'Password'
    end

    it 'パスワード確認のフィールドが表示されること' do
      expect(page).to have_field 'Password confirmation'
    end

    context 'アカウント作成するときに' do
      it '名前フィールドが空で Create Account を押下するとエラーメッセージが表示されること' do
        fill_in 'Email', with: "test@mail.com"
        fill_in 'Password', with: "12345678"
        fill_in 'Password confirmation', with: "12345678"
        click_on 'Create Account'
        expect(page).to have_content 'Nameを入力してください'
      end

      it 'パスワードとパスワード確認のフィールドの値が異なった場合、エラーメッセージが表示されること' do
        fill_in 'Email', with: "テスト"
        fill_in 'Email', with: "test@mail.com"
        fill_in 'Password', with: "12345678"
        fill_in 'Password confirmation', with: "12345679"
        click_on 'Create Account'
        expect(page).to have_content 'Password confirmationとPasswordの入力が一致しません'
      end

      it 'すべてのフィールドを入力して Create Account を押下するとトップページが表示されること' do
        fill_in 'Name', with: "テスト"
        fill_in 'Email', with: "test@mail.com"
        fill_in 'Password', with: "12345678"
        fill_in 'Password confirmation', with: "12345678"
        click_on 'Create Account'
        link = all('a')[1]
        user_id = User.find_by(Email: "test@mail.com")
        expect(page).to have_content 'アカウント登録が完了しました。'
        expect(page).to have_content 'テスト'
        expect(link[:href]).to eq edit_user_path(user_id)
      end
    end
  end
end
