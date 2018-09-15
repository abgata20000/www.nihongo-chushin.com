# frozen_string_literal: true
Room.delete_all
User.all.each do |user|
  Room.create!(
    name: "#{user.nickname}の部屋",
    user: user
  )
end
