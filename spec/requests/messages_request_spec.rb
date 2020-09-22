require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe 'create path' do
    it 'directs valid calls to SmsService' do
      params = { to_number: '1112223333', content: 'hello world' }
      expect(SmsService).to receive(:call).with(kind_of(Message))

      post '/messages', params: params
      expect(response.status).to eq(200)
    end

    it 'creates Message' do
      params = { to_number: '1112223333', content: 'hello world' }

      expect{ post '/messages', params: params }.to change { Message.count }.by(1)
      expect(response.status).to eq(200)
    end

    it 'returns error messages if Message is not valid' do
      params = { to_number: nil, content: nil }

      expect{ post '/messages', params: params }.to change { Message.count }.by(0)

      expect(response.status).to eq(400)
      response_json = JSON.parse(response.body)
      expect(response_json).to include("Content can't be blank")
      expect(response_json).to include("To number can't be blank")
    end
  end

  describe 'set_delivery_status path' do
    let(:message) { Message.create({ to_number: '1112223333', content: 'something profound' }) }

    it 'updates message status' do
      uuid = SecureRandom.uuid
      params = { id: message.id, status: 'delivered', message_id: uuid }
      post set_delivery_status_path(params)
      message.reload
      expect(message.status).to eq('delivered')
      expect(message.message_id).to eq(uuid)
    end
  end
end
