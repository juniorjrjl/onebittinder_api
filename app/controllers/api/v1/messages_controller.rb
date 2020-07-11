class Api::V1::MessagesController < ApplicationController

    def messages_history
        @messages = Message.where(match_id: params[:match_id]).order(:created_at)
        render json: @messages
    end

    def create
        @message = Message.create(message_params)
        @message.user = current_user
        save_message || render_error
    end

    def render_error
        render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end

    private

    def save_message
        if @message.save
            head :ok
        end
    end

    def message_params
        params.require(:message).permit(:body, :match_id)
    end
end