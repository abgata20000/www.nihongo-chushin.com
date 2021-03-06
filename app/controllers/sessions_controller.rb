class SessionsController < ApplicationController
  before_action :redirect_to_root_with_logged_in, only: %w[new create]
  before_action :set_icon_shuffle, only: %w[new create]
  before_action :set_user_session, only: %w[new create]

  def new; end

  def create
    if @user_session.save
      if @user_session.room_id.present?
        redirect_to room_joins_path(room_id: @user_session.room_id)
      else
        redirect_to rooms_path
      end
    else
      render :new
    end
  end

  def destroy
    reset_current_user unless current_user.room
    redirect_to root_path
  end

  private

  def set_icon_shuffle
    @icons = Icon.icons.shuffle
  end

  def set_user_session
    @user_session = UserSession.new(user_session_params)
  end

  def user_session_params
    tmp = params.fetch(:user_session, {}).permit(:nickname, :icon, :color, :room_id)
    tmp[:user] = current_user
    tmp[:ip] = remote_ip
    tmp[:user_agent] = user_agent
    tmp[:icon] = @icons.first.name if Icon.special_icon?(tmp[:icon]) || tmp[:icon].blank?
    tmp[:room_id] = room_id if room_id.present?
    tmp
  end

  def redirect_to_root_with_logged_in
    return unless logged_in?

    redirect_to root_path
  end

  def room_id
    params[:room_id]
  end
end
