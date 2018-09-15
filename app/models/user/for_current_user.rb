class User < ApplicationRecord
  class ForCurrentUser < ActiveType::Record[User]
    def join_room(room)
      update!(room: room, color: room.random_color, into_the_room_at: now, last_commented_at: now, last_connected_at: now)
    end

    def leave_room
      # prev_room = room
      update!(room: nil, into_the_room_at: nil, last_commented_at: nil, last_connected_at: nil)
      # prev_room.close_with_leave_if_empty_users
      # prev_room.move_owner_first_user
    end
  end
end
