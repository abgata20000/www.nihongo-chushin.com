class ApiUserSession < ActiveTypeRecord
  attribute :user
  attribute :nickname, :string
  attribute :icon, :string
  attribute :user_agent, :string
  attribute :ip, :string

  validates :nickname, presence: true, length: { in: 2..20 }
  validates :icon, presence: true
  validates :user, presence: true

  after_save :update_user

  delegate :show_attributes, to: :user

  private

  def update_user
    user.login(login_params)
  end

  def login_params
    {
      nickname: nickname,
      icon: icon,
      user_agent: user_agent,
      ip: ip,
      last_logged_in_at: Time.zone.now
    }
  end
end
