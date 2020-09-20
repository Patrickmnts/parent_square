class MessagesController < ApplicationController
  def create
    message = Message.new(permitted_message_params)

    if message.save
      SmsService.call(message)
      render json: {}, status: 200
    else
      render json: message.errors.full_messages, status: 400
    end
  end

  private
  def permitted_message_params
    params.permit(:to_number, :content)
  end
end