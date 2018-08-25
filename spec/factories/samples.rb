FactoryBot.define do
  factory :sample do
    name do
      "sample(#{Sample.count + 1})"
    end
    comment { "コメントです" }
  end
end
