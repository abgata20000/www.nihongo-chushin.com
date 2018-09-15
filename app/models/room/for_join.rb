class Room < ApplicationRecord
  class ForJoin < ActiveType::Record[Room]
    def exists_username?(my_user)
      nicknames = users.pluck(:nickname).map do |name|
        name.strip.downcase
      end
      nicknames.include?(my_user.nickname.downcase)
    end
  end
end
