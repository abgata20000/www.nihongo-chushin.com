FactoryBot.define do
  factory :room do
    name { "部屋(#{Room.next_id})" }
  end
end
