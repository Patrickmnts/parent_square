class SmsService < ApplicationService
  attr_reader :to_number, :message

  def initialize(message)
    if !message.is_a?(Message)
      raise ArgumentError.new('Please pass Message object to SmsService')
    end

    @message = message
  end

  def call

  end
end