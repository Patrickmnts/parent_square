class SmsService < ApplicationService
  attr_reader :message, :provider

  def initialize(message)
    if !message.is_a?(Message)
      raise ArgumentError.new('Please pass Message object to SmsService')
    end

    @message = message
    @provider = determine_provider
  end

  def call

  end

  private
  def determine_provider
    if @message.provider_name.present?
      PROVIDERS.select { |provider| provider.name != @message.provider_name }.first
    else
      select_new_provider
    end
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
end