FactoryBot.define do
  factory :chat do
    comment { "コメント(#{Room.next_id})" }
  end
end
