class RoomsController < ApplicationController
  before_action :check_login, only: %w[new create]
  before_action :check_current_room, only: %w[show edit update]
  before_action :check_room_owner, only: %w[edit update]
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

  def check_current_room
    return if id.to_i == current_user.room_id

    redirect_to rooms_path
  end

  def controller_params
    params.fetch(:room, {}).permit(:name, :num, :password)
  end

  def check_login
    return if logged_in?
    redirect_to rooms_path
  end
end
