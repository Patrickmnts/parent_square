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

  def set_delivery_status
    message = Message.find(params[:id])
    return unless message.present?

    message.update_attributes(permitted_message_callback_params)
  end

  private
  def permitted_message_params
    params.permit(:to_number, :content)
  end

  def permitted_message_callback_params
    params.permit(:status, :message_id)
  end
end