module Rooms
  class DriveOutUsersController < ::Rooms::ApplicationController
    def destroy
      force_leave
    end

    private

    def force_leave
      target_user.force_leave!
      redirect_to room_path(current_user.room)
    #rescue StandardError => _e
    #  redirect_to room_path(current_user.room)
    end

    def target_user
      @target_user ||= user_class.find(user_id)
    end

    def user_id
      params[:id]
    end

    def user_class
      User::ForDriveOut
    end
  end
end
