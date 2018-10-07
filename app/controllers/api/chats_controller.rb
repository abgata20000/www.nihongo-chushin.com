module Api
  class ChatsController < ::Api::ApplicationController
    def index
      search_last_chat_id = last_chat_id
      @chats = current_user.room.chats.where.has{id > search_last_chat_id}.order(id: :desc).limit(current_user.room.show_comment_count)
      render json: @chats.map(&:show_attributes)
    end

    def create
      @chat = Chat::ForPost.new(controller_params)
      if @chat.save
        render json: @chat.show_attributes
      else
        render json: @chat.show_errors, status: 400
      end
    end

    private

    def last_chat_id
      params[:last_chat_id].to_i
    end

    def controller_params
      tmp = params.permit(:comment)
      tmp[:user] = current_user
      tmp
    end
  end
end
