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

class Chat < ApplicationRecord
  class ExpireDataRemover < ActiveType::Record[Chat]
    DEFAULT_EXPIRE_DATA_REMOVE_DAY = 180
    class << self
      def run
        num = targets.delete_all
        notice_to_slack(num)
        num
      end

      private

      def notice_to_slack(num)
        return if num.zero?
        message = "[ExpireDataRemover] #{expire_day}日を経過したコメント#{num}件を削除しました。"
        NihongoChushin::SlackUtils.post(message)
      end

      def targets
        target_date = expire_day.days.ago.beginning_of_day
        where.has { updated_at < target_date }
      end

      def expire_day
        ENV["EXPIRE_DATA_REMOVE_DAY"].present? ? ENV["EXPIRE_DATA_REMOVE_DAY"].to_i : DEFAULT_EXPIRE_DATA_REMOVE_DAY
      end
    end
  end
end
