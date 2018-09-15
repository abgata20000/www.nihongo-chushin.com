# frozen_string_literal: true

module ControllerMacros
  def last_email
    ActionMailer::Base.deliveries.last
  end

  def visit_user(user = create(:user))
    cookies.signed[:user_token] = {
      value: user.token,
      expires: 10.years.from_now
    }
  end
end
