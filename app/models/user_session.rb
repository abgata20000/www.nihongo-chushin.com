class UserSession < ActiveType::Object
  attribute :user
  attribute :nickname, :string
  attribute :email, :string
  attribute :icon, :string
  attribute :color, :string
  attribute :sound, :string
  attribute :room_id, :integer
  attribute :user_agent, :string
  attribute :ip, :string

  default_value_for :color do
    User::DEFAULT_COLOR
  end
  default_value_for :icon do
    User::DEFAULT_ICON
  end
  default_value_for :sound do
    User::DEFAULT_SOUND
  end

  validates :user, presence: true
  validates :nickname, presence: true, length: { in: 2..20 }
  validates :color, presence: true
  validates :icon, presence: true
  validates :sound, presence: true

  after_save :update_user

  private

  def update_user
    user.login(login_params)
  end

  def login_params
    {
      nickname: nickname,
      color: color,
      icon: icon,
      sound: sound,
      user_agent: user_agent,
      ip: ip,
      last_logged_in_at: Time.zone.now
    }
  end

  def login_message
    "[login]#{user.massage_info}"
  end
end
