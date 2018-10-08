module Api
  class RoomsController < ::Api::ApplicationController
    def show
      @room = ActiveType.cast(current_room, Room::ForApi)
      render json: @room.show_attributes
    rescue => _e
      render json: []
    end
  end
end
