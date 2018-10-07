class User < ApplicationRecord
  class ForApi < ActiveType::Record[User]
    class << self
      def room_users(current_user)
        where(room: current_user.room).into_the_room_at_asc
      end
    end

    def show_attributes
      {
          id: id,
          name: name,
          nickname: nickname,
          color: color,
          sound: sound,
          icon: icon,
          is_mobile: is_mobile,
          language: language,
          is_room_owner: room_owner?,
          color_class: color_class,
          icon_url: icon_url
      }
    end
  end
end
