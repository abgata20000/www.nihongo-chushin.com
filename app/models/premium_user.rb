class PremiumUser < ApplicationRecord
  belongs_to :user

  validates :email, allow_nil: true, email: { not_duplication: true }
  validates :name, allow_nil: true, uniqueness: true
end
