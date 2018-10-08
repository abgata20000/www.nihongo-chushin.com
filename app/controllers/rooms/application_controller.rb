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

      @room = room_class.enabled.find_by!(id: room_id)
    rescue StandardError => _e
      redirect_to rooms_path, notice: "部屋が存在しません。"
    end

    def check_current_room
      redirect_to room_path(current_room) if current_room.present?
    end

    def ban_or_drive_out_user(force_ban = false)
      user_id = params[:user_id]
      user = User.find(user_id)
      if force_ban
        user.ban!
      else
        user.drive_out!
      end
      redirect_to room_path(current_user.room)
    rescue StandardError => _e
      redirect_to room_path(current_user.room)
    end
  end
end
