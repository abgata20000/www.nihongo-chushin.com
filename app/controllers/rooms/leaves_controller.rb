module Rooms
  class LeavesController < ::Rooms::ApplicationController
    skip_before_action :check_current_room
    def destroy
      current_user.leave_room
      redirect_to rooms_path
    end
  end
end
