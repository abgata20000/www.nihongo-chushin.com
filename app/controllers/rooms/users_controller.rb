module Rooms
  class UsersController < ::Rooms::ApplicationController
    def index
      @users = @room.users
    end
  end
end
