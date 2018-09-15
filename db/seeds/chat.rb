# frozen_string_literal: true
Chat.delete_all
room = Room.create!(
    name: "固定部屋",
    user: User.random,
    is_fixed: true,
    is_public: true
)
room.user.update!(room: room)
10.times do |i|
  num = i + 1
  Chat.create!(
          user: room.user,
          comment: "コメントです(#{num})"
  )
end
