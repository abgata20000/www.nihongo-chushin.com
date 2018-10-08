module Rooms
  class UsersController < ::Rooms::ApplicationController
    def index
      @users = @room.users.into_the_room_at_asc
    end
  end
end
