module Api
  module V1
    class RoomsController < ::Api::V1::ApplicationController
      private

      def model_class
        Room::ForApi
      end
    end
  end
end
