module Api
  class MyPagesController < ::Api::ApplicationController
    def show
      @user = ActiveType.cast(current_user, User::ForApi)
      render json: @user.show_attributes
    end
  end
end
