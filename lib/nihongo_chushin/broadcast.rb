# frozen_string_literal: true

module NihongoChushin
  class Broadcast
    class << self
      def broadcast(label, user_id: nil, chat_id: nil, room_id: nil,
                    fetch_comments: false, fetch_room: false, fetch_users: false, force_disconnect: false)
        params = {
          fetch_comments: fetch_comments,
          fetch_room: fetch_room,
          fetch_users: fetch_users,
          user_id: user_id,
          chat_id: chat_id,
          room_id: room_id,
          force_disconnect: force_disconnect
        }
        ActionCable.server.broadcast(label, params)
      end
    end
  end
end
