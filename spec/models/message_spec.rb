require 'rails_helper'

RSpec.describe Message, type: :model do
  it 'has an active model' do
    expect{ Message.create }.to change { Message.count }.by 1
  end
end
