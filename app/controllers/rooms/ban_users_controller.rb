module Rooms
  class BanUsersController < ::Rooms::ApplicationController
    def destroy
      ban_or_drive_out_user(true)
    end
  end
end
