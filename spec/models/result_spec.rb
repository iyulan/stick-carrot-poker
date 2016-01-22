require 'rails_helper'

describe Result do
  describe 'validations' do
    it { should validate_presence_of(:date) }
  end

  describe 'associtations' do
    it { should belong_to(:act) }
  end
end
