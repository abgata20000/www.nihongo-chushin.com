# == Schema Information
#
# Table name: users
#
#  id                          :bigint(8)        not null, primary key
#  color(色)                    :string
#  enabled(有効・無効)              :boolean          default(TRUE), not null
#  icon(アイコン)                  :string
#  into_the_room_at            :datetime
#  ip(IP)                      :string
#  is_connected(接続判定)          :boolean          default(FALSE)
#  is_mobile(Mobile)           :boolean          default(FALSE)
#  language(言語)                :string           default("ja"), not null
#  last_commented_at           :datetime
#  last_connected_at           :datetime
#  last_logged_in_at(最終ログイン時間) :datetime
#  memo(メモ)                    :text
#  name(ユーザー名)                 :string
#  nickname(ユーザー名(ニックネーム))     :string
#  role(権限)                    :integer          default("user"), not null
#  sound(効果音)                  :string
#  token(トークン)                 :string
#  user_agent(UA情報)            :text
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  room_id(部屋ID)               :integer
#
# Indexes
#
#  index_users_on_into_the_room_at   (into_the_room_at)
#  index_users_on_language           (language)
#  index_users_on_last_commented_at  (last_commented_at)
#  index_users_on_last_connected_at  (last_connected_at)
#  index_users_on_last_logged_in_at  (last_logged_in_at)
#  index_users_on_name               (name) UNIQUE
#  index_users_on_room_id            (room_id)
#  index_users_on_token              (token) UNIQUE
#  index_users_on_updated_at         (updated_at)
#

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
      { force_disconnect: true, user_id: id }
    end

    def echo_force_leave_system_comment
      message = "#{nickname}さんが退室させられました。"
      echo_system_comment(room_id, message)
    end
  end
end
