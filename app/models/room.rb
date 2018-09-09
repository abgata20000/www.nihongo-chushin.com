class Room < ApplicationRecord
  LIMIT_NUM = 100
  belongs_to :user
  has_many :users
  has_many :chats

  default_value_for :connection_disconnected_time, 3600
  default_value_for :comment_disconnected_time, 3600
  default_value_for :num, 5
  default_value_for :language, "ja"
  default_value_for :is_public, false
  default_value_for :is_visible, true
  default_value_for :can_knock, false
  default_value_for :is_fixed, false
  default_value_for :show_comment_count, 30

  validates :name, presence: true, length: { in: 2..20 }
  validates :num, presence: true, numericality: { greater_than_or_equal_to: 2, less_than_or_equal_to: 10 }
  validates :connection_disconnected_time, presence: true, numericality: { greater_than_or_equal_to: 10, less_than_or_equal_to: 3600 }
  validates :comment_disconnected_time, presence: true, numericality: { greater_than_or_equal_to: 10, less_than_or_equal_to: 3600 }

  scope :enabled, -> { where(deleted_at: nil) }
  scope :disabled, -> { where.not(deleted_at: nil) }
  scope :newest, -> { order(updated_at: :desc) }

  class << self
    def active_rooms
      includes(:users).enabled.order(is_fixed: :desc).newest.limit(LIMIT_NUM)
    end
  end
end
