class User < ApplicationRecord
  class ForCurrentUser < ActiveType::Record[User]
    def join_room(room)
      result = update!(room: room, color: room.random_color, into_the_room_at: now, last_commented_at: now, last_connected_at: now)
      notice_to_slack(join_room_message)
      into_the_room_system_comment
      result
    end

    def leave_room
      notice_to_slack(leave_room_message)
      is_perv_room_owner = room_owner?
      prev_room = room
      update!(room: nil, into_the_room_at: nil, last_commented_at: nil, last_connected_at: nil)
      leave_the_room_system_comment(prev_room.id)
      prev_room.close_with_leave_if_empty_users
      prev_room.move_owner_first_user if is_perv_room_owner
    end

    private

    def join_room_message
      "[join]#{massage_info}"
    end

    def leave_room_message
      "[leave]#{massage_info}"
    end

    def into_the_room_system_comment
      message = "#{nickname}さんが入室しました。"
      echo_system_comment(room_id, message)
    end

    def create_the_room_system_comment
      message = "#{nickname}さんが部屋を作成しました。"
      echo_system_comment(room_id, message)
    end

    def leave_the_room_system_comment(prev_room_id)
      message = "#{nickname}さんが退室しました。"
      echo_system_comment(prev_room_id, message)
    end

    def echo_system_comment(room_id, message)
      Chat::SystemMessage.echo(room_id, message, fetch_users: true)
    end
  end
end
