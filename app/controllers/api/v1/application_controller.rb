module Api
  module V1
    class ApplicationController < ::Api::ApplicationController
      before_action :token_auth!
      before_action :show_model_exists?, only: %w[show]
      before_action :destroy_model_exists?, only: %w[destroy]

      def index
        render json: list
      end

      def show
        render json: model.show_attributes
      end

      def create
        create_or_update(assigned_new_model)
      end

      def update
        create_or_update(assigned_update_model)
      end

      def destroy
        destroy_model.delete
        head :no_content
      end

      private

      def show_model_exists?
        raise ActiveRecord::RecordNotFound if model.nil?
      end

      def update_model_exists?
        raise ActiveRecord::RecordNotFound if update_model.nil?
      end

      def destroy_model_exists?
        raise ActiveRecord::RecordNotFound if destroy_model.nil?
      end

      def controller_params
        raise "継承先でオーバーライドすること"
      end

      def create_params
        controller_params
      end

      def update_params
        controller_params
      end

      def model_class
        raise "継承先でオーバーライドすること"
      end

      def list_model_class
        model_class
      end

      def new_model_class
        model_class
      end

      def update_model_class
        model_class
      end

      def destroy_model_class
        model_class
      end

      def list
        list_model_class.all.map(&:show_attributes)
      end

      def model
        @model ||= model_class.find(id)
      end

      def new_model
        @new_model ||= new_model_class.new
      end

      def update_model
        @update_model ||= update_model_class.find(id)
      end

      def destroy_model
        @destroy_model ||= destroy_model_class.find(id)
      end

      def assigned_new_model
        new_model.assign_attributes(create_params)
        new_model
      end

      def assigned_update_model
        raise ActiveRecord::RecordNotFound if update_model.nil?

        update_model.assign_attributes(update_params)
        update_model
      end

      def create_or_update(my_model)
        if my_model.save
          render json: my_model.show_attributes, status: :ok
        else
          render json: my_model.show_errors, status: :ok
        end
      end

      def token
        params[:token] || request.headers[:TOKEN]
      end

      def id
        params[primary_key]
      end

      def primary_key
        :id
      end

      # kaminariを使っている場合に呼び出す
      def set_paginate_headers
        response.headers["Limit-Value"] = list_model_class.limit_value
        response.headers["Total-Pages"] = list_model_class.total_pages
        response.headers["Current-Page"] = list_model_class.current_page
        response.headers["Next-Page"] = list_model_class.next_page
        response.headers["Prev-Page"] = list_model_class.prev_page
        response.headers["First-Page"] = list_model_class.first_page?
        response.headers["Last-Page"] = list_model_class.last_page?
        response.headers["Out-Of-Range"] = list_model_class.out_of_range?
      end

      # 必要なら継承先で定義する
      def token_auth!
        return if current_user&.nickname.present?

        render json: { error: "unauthorized token" }, status: :unauthorized
      end

      def request_token
        request.headers[:TOKEN]
      end

      def current_user
        @current_user ||= User::ForCurrentUser.find_by(token: request_token)
      end
    end
  end
end
