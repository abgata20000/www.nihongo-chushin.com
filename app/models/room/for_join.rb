class Room < ApplicationRecord
  class ForJoin < ActiveType::Record[Room]
    def random_color
      enabled_colors.sample
    end

    def exists_username?(my_user)
      nicknames = users.pluck(:nickname).map do |name|
        name.strip.downcase
      end
      nicknames.include?(my_user.nickname.downcase)
    end

    private

    def used_colors
      users.pluck(:color)
    end

    def enabled_colors
      Color.to_array - used_colors
    end
  end
end
