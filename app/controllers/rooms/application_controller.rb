module Rooms
  class ApplicationController < ::ApplicationController
    private

    def room_id
      params[:room_id]
    end
  end
end
