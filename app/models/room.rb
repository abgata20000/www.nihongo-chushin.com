class Room < ApplicationRecord
  LIMIT_NUM = 100
  DEFAULT_LANGUAGE = "ja".freeze
  DEFAULT_CONNECTION_DISCONNECTED_TIME = 3600
  DEFAULT_COMMENT_DISCONNECTED_TIME = 3600
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

  def random_color
    enabled_colors.sample
  end

  def enabled_colors
    Color.to_array - used_colors
  end

  def title_with_nums
    "(#{users.count}/#{num})#{name}"
  end

  def show_attributes
    tmp = attributes
    tmp.delete('password')
    tmp[:room_name] = title_with_nums
    tmp
  end

  private

  def used_colors
    users.pluck(:color)
  end
end
