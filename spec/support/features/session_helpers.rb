module Features
  module SessionHelpers
    def sign_in(email, password)
      within('form') do
        fill_in I18n.t('activerecord.attributes.session.email'), with: email
        fill_in I18n.t('activerecord.attributes.session.password'), with: password
      end
      click_button I18n.t('sessions.new.submit')
    end

    def sign_up(name, email, password, password_confirmation = password)
      within('form') do
        fill_in I18n.t('activerecord.attributes.user.name'), with: name
        fill_in I18n.t('activerecord.attributes.user.email'), with: email
        fill_in I18n.t('activerecord.attributes.user.password'), with: password
        fill_in I18n.t('activerecord.attributes.user.password_confirmation'), with: password_confirmation
      end
      click_button I18n.t('users.new.submit')
    end
  end
end

RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
end
