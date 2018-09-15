# frozen_string_literal: true
Room.delete_all
User.all.each do |user|
  room = Room.create!(
    name: "#{user.nickname}の部屋",
    user: user
  )
  user.update!(room: room)
end
