module Features
  module ActHelpers
    def add_act(title, points)
      within('form') do
        fill_in I18n.t('acts.index.form.title'), with: title
        fill_in I18n.t('acts.index.form.points'), with: points
      end
      click_button I18n.t('acts.index.form.create')
    end
  end
end

RSpec.configure do |config|
  config.include Features::ActHelpers, type: :feature
end
