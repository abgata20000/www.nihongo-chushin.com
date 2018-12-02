module Api
  module V1
    class SessionsController < ::Api::V1::ApplicationController
      skip_before_action :token_auth!, only: %w[create]
      skip_before_action :show_model_exists?
      skip_before_action :destroy_model_exists?

      def show
        render json: current_user.show_attributes, status: :ok
      end

      def destroy
        current_user.logout
      end

      private

      def model_class
        ApiUserSession
      end

      def controller_params
        tmp = {}
        tmp[:nickname] = validated_nickname
        tmp[:icon] = validated_icon
        tmp[:user] = user
        tmp[:ip] = remote_ip
        tmp[:user_agent] = user_agent
        tmp
      end

      def validated_icon
        params[:icon]
      end

      def validated_nickname
        params[:nickname]
      end

      def user
        token = request_token.presence || User::ForCurrentUser.create!.token
        User::ForCurrentUser.find_or_create_by!(token: token)
      end
    end
  end
end
