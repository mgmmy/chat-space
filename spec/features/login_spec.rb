# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ログイン', type: :feature do
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
end
