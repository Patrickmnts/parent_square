require 'httpclient'

class SmsService < ApplicationService
  attr_reader :message, :provider

  def initialize(message)
    if !message.instance_of?(Message)
      raise ArgumentError.new('Please pass Message object to SmsService')
    end

    @message = message
    @provider = determine_provider
  end

  def call
    if message.okay_to_deliver?
      deliver_message
    else
      false
    end
  end

  def deliver_message
    generate_http_client
    response = @client.post URI.parse(@provider.url), post_params, { "Content-Type" => "application/json" }

    if response.status == 200
      @message.update_attributes({ message_id: JSON.parse(response.body)["message_id"] })
    else
      @message.update_attribute(:status, Message::STATUS_FAILED)
    end
  end

  private
  def generate_http_client
    @client ||= HTTPClient.new
  end

  def post_params
    { to_number: @message.to_number,
      message: @message.content,
      callback_url: message_callback_url(id: @message.id)
    }.to_json
  end

  def determine_provider
    if @message.provider_name.present?
      provider = PROVIDERS.select { |provider| provider.name != @message.provider_name }.first
    else
      provider = select_new_provider
    end
    @message.update_attribute(:provider_name, provider.name)
    provider
  end

  def select_new_provider
    num = rand(1..10)
    case
    when num <= 3
      PROVIDER_1
    else
      PROVIDER_2
    end
  end

  def message_callback_url(message)
    Rails.application.routes.url_helpers.set_delivery_status_url(id: @message.id)
  end

  def set_provider_on_message
    @message.update_attribute(:provider_name, @provider.name)
  end
end