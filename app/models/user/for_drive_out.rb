class User < ApplicationRecord
  class ForDriveOut < ForCurrentUser
    def force_leave!
      echo_force_leave_system_comment
      leave_room(force_leave: true)
      broadcast_disconnect
    end

    private

    def user_label
      "user:#{id}"
    end

    def broadcast_disconnect
      NihongoChushin::Broadcast.broadcast(user_stream_label, broadcast_disconnect_params)
    end

    def broadcast_disconnect_params
      {force_disconnect: true, user_id: id}
    end

    def echo_force_leave_system_comment
      message = "#{nickname}さんが退室させられました。"
      echo_system_comment(room_id, message)
    end
  end
end
