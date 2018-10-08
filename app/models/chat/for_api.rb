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
  class ForApi < ActiveType::Record[Chat]
    class << self
      def chats(current_user, last_chat_id)
        limit = current_user.room_id.present? ? current_user.room.show_comment_count : 30
        where(room_id: current_user.room_id).where.has{id > last_chat_id}.order(id: :desc).limit(limit)
      end
    end

    def show_attributes
      super.merge(
               icon_url: icon_url,
               color_class: color_class
      )
    end
  end
end
