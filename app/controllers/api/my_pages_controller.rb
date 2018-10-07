module Api
  class MyPagesController < ::Api::ApplicationController
    def show
      render json: current_user.show_my_page_attributes
    end
  end
end
