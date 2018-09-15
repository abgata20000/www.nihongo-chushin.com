module Rooms
  class ApplicationController < ::ApplicationController
    before_action :check_current_room
    before_action :find_room

    private

    def room_id
      params[:room_id]
    end

    def room_class
      Room
    end

    def find_room
      return if room_id.blank?

      @room = room_class.enabled.find_by(id: room_id)
    rescue StandardError => _e
      redirect_to rooms_path
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
