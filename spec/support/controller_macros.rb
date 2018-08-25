# frozen_string_literal: true

module ControllerMacros
  def last_email
    ActionMailer::Base.deliveries.last
  end

  def login_user(user = create(:user))
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @logined_admin = user
    sign_in user
  end
end
