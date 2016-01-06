require 'rails_helper'

feature 'Sessions' do
  let(:password) { '123456' }
  let(:incorrect_password) { '654321' }
  let(:user) { create(:user) }

  scenario 'load sign_in page' do
    visit sign_in_path
    expect(page).to have_content('Log In')
  end

  scenario 'success sign in' do
    visit sign_in_path

    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: password
    end
    click_button 'Log In'

    expect(page).to have_selector('div.alert.alert-success', text: 'Welcome back!')
  end

  scenario 'failed sign in' do
    visit sign_in_path

    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: incorrect_password
    end
    click_button 'Log In'

    expect(page).to have_selector('div.alert.alert-warning', text: 'E-mail and/or password is incorrect.')
  end
end
