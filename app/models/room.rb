# == Schema Information
#
# Table name: rooms
#
#  id                                             :bigint(8)        not null, primary key
#  can_knock(ノック可能かどうか)                           :boolean          default(FALSE), not null
#  comment_disconnected_time(最終コメントから強制退出までの時間)   :integer          default(600), not null
#  connection_disconnected_time(接続切れからの強制退出までの時間) :integer          default(60), not null
#  deleted_at(削除時間)                               :datetime
#  is_fixed(固定部屋)                                 :boolean          default(FALSE), not null
#  is_public(公開部屋フラグ)                             :boolean          default(FALSE), not null
#  is_visible(表示・非表示)                             :boolean          default(TRUE), not null
#  language(言語)                                   :string           default("ja"), not null
#  memo(メモ)                                       :text
#  name(部屋名)                                      :string           not null
#  num(人数)                                        :integer          default(5), not null
#  password(パスワード)                                :string
#  show_comment_count(表示するコメント数)                  :integer          default(100), not null
#  created_at                                     :datetime         not null
#  updated_at                                     :datetime         not null
#  user_id(オーナーユーザーID)                            :integer          not null
#
# Indexes
#
#  index_rooms_on_created_at  (created_at)
#  index_rooms_on_deleted_at  (deleted_at)
#  index_rooms_on_language    (language)
#  index_rooms_on_updated_at  (updated_at)
#  index_rooms_on_user_id     (user_id)
#

class Room < ApplicationRecord
  LIMIT_NUM = 100
  DEFAULT_LANGUAGE = "ja".freeze
  DEFAULT_CONNECTION_DISCONNECTED_TIME = 60
  DEFAULT_COMMENT_DISCONNECTED_TIME = 900
  DEFAULT_NUM = 5
  DEFAULT_SHOW_COMMENT_COUNT = 30

  belongs_to :user
  has_many :users
  has_many :chats

  default_value_for :connection_disconnected_time, DEFAULT_CONNECTION_DISCONNECTED_TIME
  default_value_for :comment_disconnected_time, DEFAULT_COMMENT_DISCONNECTED_TIME
  default_value_for :num, DEFAULT_NUM
  default_value_for :language, DEFAULT_LANGUAGE
  default_value_for :is_public, false
  default_value_for :is_visible, true
  default_value_for :can_knock, false
  default_value_for :is_fixed, false
  default_value_for :show_comment_count, DEFAULT_SHOW_COMMENT_COUNT

  validates :name, presence: true, length: { in: 1..20 }
  validates :num, presence: true, numericality: { greater_than_or_equal_to: 2, less_than_or_equal_to: 10 }
  validates :connection_disconnected_time, presence: true, numericality: { greater_than_or_equal_to: 10, less_than_or_equal_to: DEFAULT_CONNECTION_DISCONNECTED_TIME }
  validates :comment_disconnected_time, presence: true, numericality: { greater_than_or_equal_to: 10, less_than_or_equal_to: DEFAULT_COMMENT_DISCONNECTED_TIME }

  scope :enabled, -> { where(deleted_at: nil) }
  scope :disabled, -> { where.not(deleted_at: nil) }
  scope :newest, -> { order(updated_at: :desc) }

  class << self
    def active_rooms
      includes(:users).enabled.order(is_fixed: :desc).newest.limit(LIMIT_NUM)
    end
  end

  def max?
    num <= users.size
  end

  def enabled?
    deleted_at.nil?
  end

  def random_color
    enabled_colors.sample
  end

  def enabled_colors
    Color.to_array - used_colors
  end

  def title_with_nums
    "#{name}(#{users.count}/#{num})"
  end

  def show_attributes
    super.merge(room_name: title_with_nums)
  end

  def close
    update(deleted_at: now)
  end

  def close_with_leave_if_empty_users
    return if is_fixed
    return if users.count.positive?

    close
  end

  def owner_transfer(to_user)
    return if is_fixed
    return unless to_user
    return unless to_user.room_id == id

    update(user: to_user)
    move_owner_system_comment
  end

  def move_owner_first_user
    owner_transfer(first_user)
  end

  private

  def first_user
    users.into_the_room_at_asc.first
  end

  def used_colors
    users.pluck(:color)
  end

  def move_owner_system_comment
    return unless user

    message = "#{user.nickname}さんに管理権限が移動しました。"
    echo_system_comment(message)
  end

  def echo_system_comment(message)
    Chat::SystemMessage.echo(id, message, fetch_users: true)
  end

  def ignore_show_attribute_keys
    ["password"]
  end
end
