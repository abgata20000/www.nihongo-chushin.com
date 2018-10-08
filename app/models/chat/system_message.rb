# == Schema Information
#
# Table name: chats
#
#  id                               :bigint(8)        not null, primary key
#  color(コメント時の色)                   :string
#  comment(コメント内容)                  :text
#  deleted_at(削除時間)                 :datetime
#  icon(コメント時のアイコン)                 :string
#  nickname(コメントした時のニックネーム)         :string
#  system_message(システムメッセージかどうかの判定) :boolean          default(TRUE), not null
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  room_id(部屋ID)                    :integer          not null
#  user_id(ユーザーID)                  :integer
#
# Indexes
#
#  index_chats_on_created_at  (created_at)
#  index_chats_on_deleted_at  (deleted_at)
#  index_chats_on_room_id     (room_id)
#  index_chats_on_updated_at  (updated_at)
#  index_chats_on_user_id     (user_id)
#

class Chat < ApplicationRecord
  class SystemMessage < ActiveType::Record[Chat]
    include Broadcastable
    default_value_for :system_message, true

    class << self
      def echo(room_id, comment, fetch_comments: true, fetch_users: false, fetch_room: false)
        create!(room_id: room_id, comment: comment,
                fetch_comments: fetch_comments,
                fetch_room: fetch_room,
                fetch_users: fetch_users
        )
      end
    end
  end
end
