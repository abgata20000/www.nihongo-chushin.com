class Chat < ApplicationRecord
  module Broadcastable
    extend ActiveSupport::Concern

    included do
      attribute :fetch_comments, :boolean
      attribute :fetch_room, :boolean
      attribute :fetch_users, :boolean

      default_value_for :fetch_comments, true
      default_value_for :fetch_room, false
      default_value_for :fetch_users, false

      after_save :broadcast
    end

    private

    def room_label
      "room:#{room_id}"
    end

    def broadcast
      NihongoChushin::Broadcast.broadcast(room_label, broadcast_params)
    end

    def broadcast_params
      {
          chat_id: id,
          user_id: user_id,
          room_id: room_id,
          fetch_comments: fetch_comments,
          fetch_room: fetch_room,
          fetch_users: fetch_users
      }
    end
  end
end
