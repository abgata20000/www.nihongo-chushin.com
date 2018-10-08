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
  class ForCurrentUser < ActiveType::Record[User]
    def join_room(room, create_room: false)
      result = update!(room: room, color: room.random_color, into_the_room_at: now, last_commented_at: now, last_connected_at: now)
      notice_to_slack(join_room_message)
      into_the_room_system_comment unless create_room
      result
    end

    def leave_room(force_leave: false)
      notice_to_slack(leave_room_message)
      is_perv_room_owner = room_owner?
      prev_room = room
      update!(room: nil, into_the_room_at: nil, last_commented_at: nil, last_connected_at: nil)
      leave_the_room_system_comment(prev_room.id) unless force_leave
      prev_room.close_with_leave_if_empty_users
      prev_room.move_owner_first_user if is_perv_room_owner
    end

    def create_the_room_system_comment(room_id)
      message = "#{nickname}さんが部屋を作成しました。"
      echo_system_comment(room_id, message)
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

    def leave_the_room_system_comment(prev_room_id)
      message = "#{nickname}さんが退室しました。"
      echo_system_comment(prev_room_id, message)
    end

    def echo_system_comment(room_id, message)
      Chat::SystemMessage.echo(room_id, message, fetch_users: true)
    end
  end
end
