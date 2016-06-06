require 'rails_helper'

RSpec.describe Message, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:message)).to be_valid
  end
  it 'requires the presence of a title' do
    expect(FactoryGirl.build(:message, title: '')).to be_invalid
  end
end
