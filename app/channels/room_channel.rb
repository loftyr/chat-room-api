class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_#{params[:room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
      message = Message.create!(
        content: data["message"],
        username: data["username"],
        room_id: data["room_id"]
      )

      ActionCable.server.broadcast(
        "room_#{data['room_id']}",
        {
          id: message.id,
          message: message.content,
          username: message.username,
          room_id: message.room_id,
          created_at: message.created_at
        }
      )
    end

end
