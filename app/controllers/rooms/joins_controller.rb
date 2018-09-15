module Rooms
  class JoinsController < ::Rooms::ApplicationController
    def show
      redirect_to room_path(current_room) if current_room.present?
      room = Room::ForJoin.find_by(id: room_id)
      current_user.join_room(room)
      redirect_to room_path(current_room)
    end
  end
end
