class MessageNotificationJob < ApplicationJob
    queue_as :default

    def perform(message)
        p message
        send_message(message, message.match.matcher.id)
        send_message(message, message.match.matchee.id)
    end
    
    private

    def send_message(message, user_id)
        MessageNotificationChannel.broadcast_to "message_notification_#{user_id}", 
            {user_id: message.user.id, body: message.body}
    end

end