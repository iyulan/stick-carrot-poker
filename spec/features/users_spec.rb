require 'rails_helper'

feature 'Users' do
  let(:password) { 'password' }
  let(:incorrect_password) { 'incorrect_password' }

  before do
    visit sign_up_path
  end

  scenario 'load sign_up page' do
    expect(page).to have_content(I18n.t('users.new.title'))
  end

  scenario 'success create new user' do
    user_name = Faker::Name.name

    sign_up(user_name, Faker::Internet.email, password)

    expect(page).to have_selector('div.alert.alert-success', text: I18n.t('users.create.success', name: user_name))
  end

  scenario 'failed create new user' do
    sign_up(Faker::Name.name, Faker::Internet.email, password, incorrect_password)

    expect(page).to have_selector('div.alert.alert-danger', text: I18n.t('users.create.danger'))
  end
end
