# frozen_string_literal: true

class SamplesController < ApplicationController
  include Scaffoldable

  private

  def sample_params
    params.require(:sample).permit(:name, :memo)
  end
end
