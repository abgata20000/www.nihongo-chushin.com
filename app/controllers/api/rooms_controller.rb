module Api
  class RoomsController < ::Api::ApplicationController
    def show
      @room = ActiveType.cast(current_user.room, Room::ForApi)
      render json: @room.show_attributes
    end
  end
end
