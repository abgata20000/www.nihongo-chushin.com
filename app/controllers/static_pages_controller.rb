# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def top
    @rooms = Room.all
  end

  def vue_sample; end
end
