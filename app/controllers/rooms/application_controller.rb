module Rooms
  class ApplicationController < ::ApplicationController
    before_action :check_current_room
    before_action :set_room

    private

    def room_id
      params[:room_id]
    end

    def room_class
      Room
    end

    def set_room
      return if room_id.blank?

      @room = room_class.find_by(id: room_id)
    end

    def check_room_owner
      return if current_user.room_owner?

      redirect_to room_path(current_user.room), notice: "管理者権限がありません"
    end

    def check_current_room
      redirect_to room_path(current_room) if current_room.present?
    end
  end
end
