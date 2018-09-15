FactoryBot.define do
  factory :user do
    nickname { "ユーザー(#{User.next_id})" }
  end
end
