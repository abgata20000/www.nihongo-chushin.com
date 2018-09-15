class StaticPagesController < ApplicationController
  before_action :set_top_variables, only: %w[top]
  def top; end

  def vue_sample; end

  private

  def set_top_variables
    @room = Room::ForTop.fixed_room
    @chats = @room.top_comments if @room
    redirect_to rooms_path if @chats.blank?
  end
end
