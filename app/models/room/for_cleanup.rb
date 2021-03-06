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
  class ForCleanup < ActiveType::Record[Room]
    class << self
      def run(room_id)
        room = enabled.find_by(id: room_id)
        return unless room

        room.cleanup
      end
    end

    def cleanup
      # 接続切れチェック
      users.each do |user|
        next unless user.room_expired?

        user = ActiveType.cast(user, User::ForTimeout)
        user.force_leave!
      end
      set_next_job
    end

    private

    # 部屋がまだあれば次回の切断処理をキューに設定
    def set_next_job
      return unless enabled?

      RoomCleanupJob.set(wait: connection_disconnected_time).perform_later(id)
    end
  end
end
