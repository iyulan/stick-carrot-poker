require 'rails_helper'

describe User do
  context 'validations' do
    it { should validate_presence_of(:email) }

    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:name) }

    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_confirmation_of(:password) }
  end
end
