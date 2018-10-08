module Rooms
  class OwnerTransfersController < ::Rooms::ApplicationController
    def update
      owner_transfer
    end

    private

    def owner_transfer
      user_id = params[:id]
      to_user = User.find(user_id)
      current_user.room.owner_transfer(to_user) if current_user.room_owner?
      redirect_to room_path(current_user.room)
    rescue StandardError => _e
      redirect_to room_path(current_user.room)
    end
  end
end
