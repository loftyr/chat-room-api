class Api::MessagesController < ApplicationController

  # GET /api/rooms/:room_id/messages
  def index
    messages = Message
      .where(room_id: params[:room_id])
      .order(created_at: :asc)

    render json: messages.map { |m|
      {
        id: m.id,
        message: m.content,   # rename content → message
        username: m.username,
        room_id: m.room_id,
        created_at: m.created_at
      }
    }
  end

end
