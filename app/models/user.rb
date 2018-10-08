# == Schema Information
#
# Table name: users
#
#  id                          :bigint(8)        not null, primary key
#  color(色)                    :string
#  enabled(有効・無効)              :boolean          default(TRUE), not null
#  icon(アイコン)                  :string
#  into_the_room_at            :datetime
#  ip(IP)                      :string
#  is_connected(接続判定)          :boolean          default(FALSE)
#  is_mobile(Mobile)           :boolean          default(FALSE)
#  language(言語)                :string           default("ja"), not null
#  last_commented_at           :datetime
#  last_connected_at           :datetime
#  last_logged_in_at(最終ログイン時間) :datetime
#  memo(メモ)                    :text
#  name(ユーザー名)                 :string
#  nickname(ユーザー名(ニックネーム))     :string
#  role(権限)                    :integer          default("user"), not null
#  sound(効果音)                  :string
#  token(トークン)                 :string
#  user_agent(UA情報)            :text
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  room_id(部屋ID)               :integer
#
# Indexes
#
#  index_users_on_into_the_room_at   (into_the_room_at)
#  index_users_on_language           (language)
#  index_users_on_last_commented_at  (last_commented_at)
#  index_users_on_last_connected_at  (last_connected_at)
#  index_users_on_last_logged_in_at  (last_logged_in_at)
#  index_users_on_name               (name) UNIQUE
#  index_users_on_room_id            (room_id)
#  index_users_on_token              (token) UNIQUE
#  index_users_on_updated_at         (updated_at)
#

class User < ApplicationRecord
  include UserIconSupportable
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
    notice_to_slack(logout_message)
    update!(
      room_id: nil,
      nickname: nil,
      color: Color.random.name,
      icon: Icon.random.name,
      sound: DEFAULT_SOUND,
      into_the_room_at: nil,
      last_commented_at: nil,
      last_connected_at: nil
    )
  end

  def room_owner?
    room && room.user_id == id
  end

  def login(params)
    result = update!(params)
    notice_to_slack(login_message)
    result
  end

  def enabled_colors
    return Color.all unless room

    colors = room.enabled_colors + [color]
    Color.where(name: colors)
  end

  def connected
    update(last_connected_at: now)
  end

  def commented
    update(last_commented_at: now, last_connected_at: now)
  end

  def chat_stream_label
    "chats"
  end

  def user_stream_label
    "user:#{id}"
  end

  def room_stream_label
    "room:#{room_id}"
  end

  private

  def generate_token
    self.token = SecureRandom.hex(32) if token.blank?
  end

  def login_message
    "[login]#{massage_info}"
  end

  def logout_message
    "[logout]#{massage_info}"
  end

  def massage_info
    "UserID: #{id}, Nickname: #{nickname}, Room: #{room&.name}, IP: #{ip}, Time: #{now}"
  end
end
