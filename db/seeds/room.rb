# frozen_string_literal: true
Room.delete_all
Room.create!(
        name: "固定部屋",
        user: User.random,
        is_fixed: true,
        is_public: true
)
User.all.each do |user|
  room = Room.create!(
    name: "#{user.nickname}の部屋",
    user: user
  )
  user.update!(room: room)
end
