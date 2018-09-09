class Chat < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :room

  default_value_for :system_message, true

  validates :comment, presence: true, length: { maximum: 500 }

  before_validation :set_user_attributes

  scope :enabled, -> { where(deleted_at: nil) }

  private

  def set_user_attributes
    return if user.blank?
    self.nickname = user.nickname
    self.color = user.color
    self.icon = user.icon
    self.room = user.room
    self.system_message = false
  end
end
