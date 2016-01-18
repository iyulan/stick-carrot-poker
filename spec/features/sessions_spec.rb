require 'rails_helper'

feature 'Sessions' do
  let(:password) { '123456' }
  let(:incorrect_password) { '654321' }
  let(:user) { create(:user) }

  before do
    visit sign_in_path
  end

  scenario 'load sign_in page' do
    expect(page).to have_content(I18n.t('sessions.new.title'))
  end

  scenario 'success sign in' do
    sign_in(user.email, password)

    expect(page).to have_selector('div.alert.alert-success', text: I18n.t('sessions.create.success'))
  end

  scenario 'failed sign in' do
    sign_in(user.email, incorrect_password)

    expect(page).to have_selector('div.alert.alert-warning', text: I18n.t('sessions.create.warning'))
  end
end
