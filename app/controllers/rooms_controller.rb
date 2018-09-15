class RoomsController < ApplicationController
  before_action :find_room, only: %w[show edit update]
  before_action :set_room, only: %w[new create]

  def index
    @rooms = Room.active_rooms
  end

  def show; end

  def new; end

  def create
    if @room.save
      redirect_to room_path(@room)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @room.save
      redirect_to room_path(@room)
    else
      render :edit
    end
  end

  private

  def id
    params[:room_id] || params[:id]
  end

  def set_room
    @room = Room::ForCreate.new(controller_params)
    @room.user = current_user
  end

  def find_room
    @room = Room::ForUpdate.enabled.find(id)
    @room.assign_attributes(controller_params)
  rescue StandardError => _e
    redirect_to rooms_path
  end

  def controller_params
    params.fetch(:room, {}).permit(:name, :num, :password)
  end
end
