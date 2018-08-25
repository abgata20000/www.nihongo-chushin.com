# frozen_string_literal: true

Sample.delete_all
10.times do |i|
  num = i + 1
  Sample.create!(
    name: "サンプル(#{num})",
    comment: "コメント(#{num})"
  )
end
