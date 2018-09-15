module SessionTestHelpers
  DEFAULT_PASSWORD = "password".freeze

  def sign_in_as_user(
    user = create(:user, password: DEFAULT_PASSWORD, password_confirmation: DEFAULT_PASSWORD),
    password = DEFAULT_PASSWORD
  )
    visit(new_user_session_path)
    fill_in "user_email", with: user.email
    fill_in "user_password", with: password
    click_button "Log in"
  end

  def current_path
    URI.parse(current_url).path
  end
end
