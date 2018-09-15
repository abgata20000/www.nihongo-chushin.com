module Rooms
  class JoinsController < ::Rooms::ApplicationController
    before_action :check_something

    def show
      current_user.join_room(@room)
      redirect_to room_path(current_room)
    end

    private

    def room_class
      Room::ForJoin
    end

    def check_something
      check_room_exists
      check_room_max
      check_exists_username
    end

    def check_room_exists
      redirect_to rooms_path, notice: "部屋が存在しません。" if @room.blank?
    end

    def check_room_max
      return if current_user.room_id == @room.id
      return unless @room.max?

      redirect_to rooms_path, notice: "満室です。"
    end

    def check_exists_username
      return unless @room.exists_username?(current_user)

      redirect_to rooms_path, notice: "同じ部屋で同じ名前は利用できません"
    end
  end
end
