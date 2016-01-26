require 'rails_helper'

describe Result do
  let(:user) { create(:user) }
  let(:act) { create(:act, user: user) }
  let(:result) { create(:result, act: act) }

  describe 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:act_id) }
  end

  describe 'associtations' do
    it { should belong_to(:act) }
  end

  describe '.as_json' do
    it 'return fields with act title' do
      expect(result.as_json['title']).to eq(act.title)
    end
  end
end
