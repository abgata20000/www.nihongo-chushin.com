module Api
  module Rooms
    class UsersController < ::Api::ApplicationController
      def index
        @users = User::ForApi.room_users(current_user)
        render json: @users.map(&:show_attributes)
      end
    end
  end
end
