# == Schema Information
#
# Table name: chats
#
#  id                               :bigint(8)        not null, primary key
#  color(コメント時の色)                   :string
#  comment(コメント内容)                  :text
#  deleted_at(削除時間)                 :datetime
#  icon(コメント時のアイコン)                 :string
#  nickname(コメントした時のニックネーム)         :string
#  system_message(システムメッセージかどうかの判定) :boolean          default(TRUE), not null
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  room_id(部屋ID)                    :integer          not null
#  user_id(ユーザーID)                  :integer
#
# Indexes
#
#  index_chats_on_created_at  (created_at)
#  index_chats_on_deleted_at  (deleted_at)
#  index_chats_on_room_id     (room_id)
#  index_chats_on_updated_at  (updated_at)
#  index_chats_on_user_id     (user_id)
#

FactoryBot.define do
  factory :chat do
    comment { "コメント(#{Room.next_id})" }
  end
end
