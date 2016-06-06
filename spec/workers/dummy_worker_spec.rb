require 'rails_helper'

RSpec.describe DummyWorker, type: :worker do
  before :each do
    instance.redis.ltrim(instance.queue, -1,0)
  end
  after :each do
    instance.redis.ltrim(instance.queue, -1,0)
  end

  let(:instance) { DummyWorker.new }
  let(:message) { FactoryGirl.create(:message) }

  describe '#perform' do
    it 'enqueues the message in JSON format' do
      expect do
        instance.perform(message.id)
      end.to change{
        instance.redis.llen(instance.queue)
      }.by(1)
    end
  end
 
  describe '#redis' do
    it 'is a redis instance' do
      expect(instance.redis).to be_kind_of(Redis)
    end
  end
end
