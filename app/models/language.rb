class Language < ApplicationHash
  field :name

  create(id: 1, name: "ja")
  create(id: 2, name: "en")
end
