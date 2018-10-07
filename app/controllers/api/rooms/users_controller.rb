module Api
  module Rooms
    class UsersController < ::Api::ApplicationController
      def index
        @users = current_user.room.users.into_the_room_at_asc
        render json: @users
      end
    end
  end
end
