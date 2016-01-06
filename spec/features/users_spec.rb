require 'rails_helper'

feature 'Users' do
  scenario 'load sign_up page' do
    visit sign_up_path
    expect(page).to have_content('Registration')
  end

  scenario 'success create new user' do
    user_name = Faker::Name.name

    visit sign_up_path

    within('form') do
      fill_in 'Name', with: user_name
      fill_in 'Email', with: Faker::Internet.email
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
    end
    click_button 'Register'

    expect(page).to have_selector('div.alert.alert-success', text: "Welcome, #{user_name}")
  end

  scenario 'failed create new user' do
    visit sign_up_path

    within('form') do
      fill_in 'Name', with: Faker::Name.name
      fill_in 'Email', with: Faker::Internet.email
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'incorrect_password'
    end
    click_button 'Register'

    expect(page).to have_selector('div.alert.alert-danger', text: 'Oops!')
  end
end
