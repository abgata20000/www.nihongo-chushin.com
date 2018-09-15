module Rooms
  class DriveOutUsersController < ::Rooms::ApplicationController
    def destroy
      ban_or_drive_out_user(false)
    end
  end
end
