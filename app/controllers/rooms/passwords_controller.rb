module Rooms
  class PasswordsController < ::Rooms::ApplicationController
    before_action :set_room_password

    def new; end

    def create
      if @room_password.save
        redirect_to room_joins_path(@room, password: @room_password.password)
      else
        render :new
      end
    end

    private

    def set_room_password
      @room_password = RoomPassword.new(controller_params)
    end

    def controller_params
      tmp = params.fetch(:room_password, {}).permit(:password)
      tmp[:user] = current_user
      tmp[:room] = @room
      tmp
    end
  end
end
