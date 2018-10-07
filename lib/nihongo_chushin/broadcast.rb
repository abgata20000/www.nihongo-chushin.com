# frozen_string_literal: true

module NihongoChushin
  class Broadcast
    class << self
      def broadcast(label, fetch_comments: false, fetch_room: false, fetch_users: false)
        params = {
            fetch_comments: fetch_comments,
            fetch_room: fetch_room,
            fetch_users: fetch_users,
        }
        ActionCable.server.broadcast(label, params)
      end
    end
  end
end
