require 'rails_helper'

feature 'Acts', js: true do
  let(:password) { '123456' }
  let(:user) { create(:user) }
  let!(:act) { create(:act, user: user) }

  before do
    visit sign_in_path
    sign_in(user.email, password)
    visit acts_path
  end

  scenario 'load acts index page' do
    expect(page).to have_content(I18n.t('acts.index.title'))
    expect(page).to have_content(act.title)
  end

  scenario 'add new act' do
    title = Faker::Name.title

    add_act(title, 10)

    expect(page).to have_content(title)
  end

  scenario 'edit act' do
    title = Faker::Name.title

    within('table') do
      find("a[id='edit-act-#{act.id}']").click
      find("input[id='act-title-#{act.id}']").set title
      find("a[id='update-act-#{act.id}']").click
    end

    expect(page).to have_content(title)
  end

  scenario 'delete act' do
    within('table') do
      find("a[id='delete-act-#{act.id}']").click
    end

    expect(page).not_to have_content(act.title)
  end
end
