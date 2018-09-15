module Rooms
  class LeavesController < ::Rooms::ApplicationController
    def destroy
      current_user.leave_room
      redirect_to rooms_path
    end
  end
end
