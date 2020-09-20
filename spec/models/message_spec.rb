require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'validations' do
    it 'responds invalid without a to_number' do
      message = Message.new(to_number: nil, content: 'hello world')
      expect(message).to_not be_valid
    end

    it 'responds invalid without a content' do
      message = Message.new(to_number: '1112223333', content: nil)
      expect(message).to_not be_valid
    end

    it 'responds valid with both to_number and content' do
      message = Message.new(to_number: '1112223333', content: 'hello world')
      expect(message).to be_valid
    end
  end

  describe 'should_retry?' do
    it 'returns false if status is invalid' do
      message = Message.new(to_number: '1112223333', content: 'hello world', status: Message::STATUS_INVALID)
      expect(message.status).to eq(Message::STATUS_INVALID)
      expect(message.should_retry?).to eq(false)
    end

    it 'returns false if status is delivered' do
      message = Message.new(to_number: '1112223333', content: 'hello world', status: Message::STATUS_DELIVERED)
      expect(message.status).to eq(Message::STATUS_DELIVERED)
      expect(message.should_retry?).to eq(false)
    end

    it 'returns true if status is failed' do
      message = Message.new(to_number: '1112223333', content: 'hello world', status: Message::STATUS_FAILED)
      expect(message.status).to eq(Message::STATUS_FAILED)
      expect(message.should_retry?).to eq(true)
    end
  end
end
