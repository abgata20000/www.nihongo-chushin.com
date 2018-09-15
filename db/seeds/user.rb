# frozen_string_literal: true

User.delete_all
10.times do |i|
  num = i + 1
  User.create!(
    nickname: "サンプルユーザー(#{num})"
  )
end
