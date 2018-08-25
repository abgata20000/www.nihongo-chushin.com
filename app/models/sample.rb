# frozen_string_literal: true

class Sample < ApplicationRecord
  validates :name, presence: true
  validates :memo, presence: true
end
