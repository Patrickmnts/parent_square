require 'rails_helper'

RSpec.describe SmsService do
  it 'should initialize with Message object' do
    message = Message.new(to_number: '1112223333', content: 'hello world')
    service = SmsService.new(message)

    expect(service.message).to eq(message)
  end

  it 'should raise error if initialized with hash' do
    hash = { to_number: '1112223333', content: 'good bye' }
    expect{ SmsService.new(hash) }.to raise_error(ArgumentError)
  end
end