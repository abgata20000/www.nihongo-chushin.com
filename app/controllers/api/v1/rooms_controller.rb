module Api
  module V1
    class RoomsController < ::Api::V1::ApplicationController
      private

      def model_class
        Room::ForApi
      end

      def controller_params
        params.permit(:name, :num).merge(user: current_user)
      end
    end
  end
end
