module Features
  module SessionHelpers
    def sign_in(email, password)
      within('form') do
        fill_in 'Email', with: email
        fill_in 'Password', with: password
      end
      click_button 'Log In'
    end

    def sign_up(name, email, password, password_confirmation = password)
      within('form') do
        fill_in 'Name', with: name
        fill_in 'Email', with: email
        fill_in 'Password', with: password
        fill_in 'Password confirmation', with: password_confirmation
      end
      click_button 'Register'
    end
  end
end

RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
end
