module Api
  class RoomsController < ::Api::ApplicationController
    def show
      @room = current_user.room
      render json: @room.show_attributes
    end
  end
end
