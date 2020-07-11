class Message < ApplicationRecord
  belongs_to :match
  belongs_to :user

  after_create :notify_match

  def notify_match
    MessageNotificationJob.perform_now(self)
  end
end
