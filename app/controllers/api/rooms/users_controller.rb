module Api
  module Rooms
    class UsersController < ::Apis::ApplicationController
      def index
        @users = current_user.room.users.into_the_room_at_asc.map do |user|
          user.render_view
        end
        render json: @users
      end
    end
  end
end
