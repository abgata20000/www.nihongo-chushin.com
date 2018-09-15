module RoomDecorator
  include BaseDecorator

  def current_room_num
    "(#{users.size}/#{num})"
  end

  def title_with_nums
    "(#{users.count}/#{num})#{name}"
  end
end
