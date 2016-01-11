require 'rails_helper'

describe Act do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:points) }
  end

  describe 'associtations' do
    it { should belong_to(:user) }
  end
end
