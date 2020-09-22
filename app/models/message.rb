class Message < ApplicationRecord
  validates_presence_of :to_number, :content

  STATUS_INVALID = 'invalid'
  STATUS_DELIVERED = 'delivered'
  STATUS_FAILED = 'failed'

  def should_retry?
    status == STATUS_FAILED
  end

  def okay_to_deliver?
    status.nil? || should_retry?
  end
end