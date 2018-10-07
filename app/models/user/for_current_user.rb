class User < ApplicationRecord
  class ForCurrentUser < ActiveType::Record[User]
    def join_room(room)
      result = update!(room: room, color: room.random_color, into_the_room_at: now, last_commented_at: now, last_connected_at: now)
      notice_to_slack(join_room_message)
      broadcast
      result
    end

    def leave_room
      notice_to_slack(leave_room_message)
      # prev_room = room
      room_label = room_stream_label
      update!(room: nil, into_the_room_at: nil, last_commented_at: nil, last_connected_at: nil)
      broadcast(room_label)
      # prev_room.close_with_leave_if_empty_users
      # prev_room.move_owner_first_user
    end

    private

    def join_room_message
      "[join]#{massage_info}"
    end

    def leave_room_message
      "[leave]#{massage_info}"
    end

    def broadcast(label = room_stream_label)
      NihongoChushin::Broadcast.broadcast(label, fetch_users: true)
    end
  end
end
