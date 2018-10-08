# == Schema Information
#
# Table name: premium_users
#
#  id                          :bigint(8)        not null, primary key
#  email(メールアドレス)              :string
#  ip(IP)                      :string
#  memo(メモ)                    :text
#  password_digest(パスワード(暗号化)) :string
#  user_agent(UA情報)            :text
#  username(ユーザー名)             :string
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  user_id(ユーザーID)             :integer
#
# Indexes
#
#  index_premium_users_on_email     (email) UNIQUE
#  index_premium_users_on_user_id   (user_id) UNIQUE
#  index_premium_users_on_username  (username) UNIQUE
#

class PremiumUser < ApplicationRecord
  belongs_to :user

  validates :email, allow_nil: true, email: { not_duplication: true }
  validates :name, allow_nil: true, uniqueness: true
end
