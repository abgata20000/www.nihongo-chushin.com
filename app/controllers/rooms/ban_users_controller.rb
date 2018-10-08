module Rooms
  class BanUsersController < ::Rooms::DriveOutUsersController

    private

    # TODO: 未実装
    def user_class
      User::ForBan
    end
  end
end
