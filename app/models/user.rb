class User < ApplicationRecord
  DEFAULT_ICON = "icon_1".freeze
  DEFAULT_COLOR = "black".freeze
  DEFAULT_SOUND = "silent".freeze
  DEFAULT_LANG = "ja".freeze

  belongs_to :room, optional: true
  has_many :chats
  has_one :premium_user

  enumerize :role, in: {
    guest: 0,
    user: 1,
    premium_user: 2,
    manager: 9,
    admin: 10,
    ban_user: 99
  }, scope: true

  enumerize :color, in: Color.to_array, scope: true
  enumerize :icon, in: Icon.to_array, scope: true
  enumerize :sound, in: Sound.to_array, scope: true
  enumerize :language, in: Language.to_array, scope: true

  default_value_for :role, :guest
  default_value_for :color, DEFAULT_COLOR
  default_value_for :icon, DEFAULT_ICON
  default_value_for :sound, DEFAULT_SOUND
  default_value_for :language, DEFAULT_LANG
  default_value_for :enabled, true
  default_value_for :is_mobile, false
  default_value_for :into_the_room_at, nil
  default_value_for :last_commented_at, nil
  default_value_for :last_connected_at, nil
  default_value_for :last_logged_in_at do
    Time.zone.now
  end

  # validates :token, allow_nil: true, uniqueness: true
  validates :name, allow_nil: true, uniqueness: true
  validates :icon, presence: true
  validates :color, presence: true
  validates :sound, presence: true
  validates :language, presence: true
  validates :role, presence: true

  after_initialize :generate_token

  scope :into_the_room_at_asc, -> { order(into_the_room_at: :asc) }

  def logout
    update(room_id: nil, nickname: nil, color: DEFAULT_COLOR, icon: DEFAULT_ICON, sound: DEFAULT_SOUND, into_the_room_at: nil, last_commented_at: nil, last_connected_at: nil)
  end

  private

  def generate_token
    self.token = SecureRandom.hex(32) if token.blank?
  end
end
