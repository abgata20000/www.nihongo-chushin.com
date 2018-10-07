class Room < ApplicationRecord
  class ForApi < ActiveType::Record[Room]
    def show_attributes
      super
    end
  end
end
