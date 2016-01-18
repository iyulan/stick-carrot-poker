require 'rails_helper'

feature 'Sessions' do
  let(:password) { '123456' }
  let(:incorrect_password) { '654321' }
  let(:user) { create(:user) }

  before do
    visit sign_in_path
  end

  scenario 'load sign_in page' do
    expect(page).to have_content('Log In')
  end

  scenario 'success sign in' do
    sign_in(user.email, password)

    expect(page).to have_selector('div.alert.alert-success', text: 'Welcome back!')
  end

  scenario 'failed sign in' do
    sign_in(user.email, incorrect_password)

    expect(page).to have_selector('div.alert.alert-warning', text: 'E-mail and/or password is incorrect.')
  end
end
