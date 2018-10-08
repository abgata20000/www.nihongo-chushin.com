# == Schema Information
#
# Table name: tasks
#
#  id                              :bigint(8)        not null, primary key
#  comment(コメント内容)                 :text
#  exec_count(実行回数)                :integer          default(0), not null
#  is_running(実行中の判定)              :boolean          default(FALSE), not null
#  key(キー)                         :string           not null
#  max_exec_count(最大実行回数(リセットに利用)) :integer          default(0), not null
#  name(名前)                        :string
#  total_exec_count(累計実行回数)        :integer          default(0), not null
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#
# Indexes
#
#  index_tasks_on_key  (key) UNIQUE
#

class Task < ApplicationRecord
end
