# frozen_string_literal: true

class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "chat"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def connected(_data)
    current_user.connected
    current_user.reload
    set_stream(current_user)
  end

  def connect
    current_user.connected
  end

  private

  def set_stream(user)
    stop_all_streams
    stream_from user.chat_stream_label
    stream_from user.user_stream_label
    stream_from user.room_stream_label
  end
end
