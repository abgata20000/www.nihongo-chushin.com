# == Schema Information
#
# Table name: chats
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  room_id        :integer          not null
#  nickname       :string
#  color          :string
#  icon           :string
#  comment        :text
#  system_message :boolean          default(TRUE), not null
#  deleted_at     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
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
