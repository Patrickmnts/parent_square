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

  describe 'service methods' do
    let(:message) { Message.new(to_number: '1112223333', content: 'hello world') }
    let(:service) { SmsService.new(message) }

    describe 'select_new_provider' do
      it 'should send to provider 1 more often than provider 2' do
        providers = []
        10.times do
          providers << service.send(:select_new_provider)
        end

        expect(providers.count(PROVIDER_1)).to be < providers.count(PROVIDER_2)
      end
    end

    describe 'determine_provider' do
      it 'assigns alternative provider if one is already associated with message' do
        message.update_attributes(provider_name: PROVIDER_1.name)
        service = SmsService.new(message)

        expect(service.provider).to_not eq(PROVIDER_1)
        expect(service.provider).to eq(PROVIDER_2)
      end

      it 'calls select_new_provider if no provider is present' do
        allow_any_instance_of(SmsService).to receive(:select_new_provider).once
        message.update_attributes(provider_name: PROVIDER_1.name)
        SmsService.new(message)
      end
    end
  end
end