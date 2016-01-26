require 'rails_helper'

feature 'Results', js: true do
  let(:password) { '123456' }
  let(:user) { create(:user) }
  let(:exist_act) { create(:act, user: user) }
  let!(:new_act) { create(:act, user: user) }
  let!(:result) { create(:result, act: exist_act) }

  before do
    visit sign_in_path
    sign_in(user.email, password)
    visit results_path
  end

  scenario 'load results index page' do
    expect(page).to have_content(I18n.t('results.index.title'))
  end

  scenario 'edit result' do
    date = Date.today - 1.year

    within('.table-bordered') do
      find("a[id='edit-result-#{result.id}']").click
      find("input[id='result-date-#{result.id}']").set date
      find("a[id='update-result-#{result.id}']").click
    end

    expect(page).to have_content(date)
  end

  scenario 'delete result' do
    within('.table-bordered') do
      find("a[id='delete-result-#{result.id}']").click
    end

    expect(page).not_to have_content(result.act.title)
  end
end
