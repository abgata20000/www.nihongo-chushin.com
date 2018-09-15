class Room < ApplicationRecord
  class ForTop < ActiveType::Record[Room]
    SHOW_COMMENT_NUM = 100

    class << self
      def fixed_room
        enabled.find_by(is_fixed: true, is_public: true)
      end
    end

    def top_comments(limit = SHOW_COMMENT_NUM)
      chats.enabled.where(system_message: false).order(updated_at: :desc).limit(limit)
    end
  end
end
