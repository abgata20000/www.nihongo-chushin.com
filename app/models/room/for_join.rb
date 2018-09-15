class Room < ApplicationRecord
  class ForJoin < ActiveType::Record[Room]
    def random_color
      enabled_colors.sample
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
