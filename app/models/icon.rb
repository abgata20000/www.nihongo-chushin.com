class Icon < ApplicationHash
  field :name
  field :secret
  field :special

  168.times do |i|
    id = i + 1
    create(name: "icon_#{id}", secret: false, special: false)
  end

  # シークレットアイコン
  create(name: "n-suke", secret: true, special: false)
  create(name: "suika", secret: true, special: false)
  create(name: "t-yan", secret: true, special: false)
  create(name: "yoshio", secret: true, special: false)
  create(name: "yoshio_true", secret: true, special: false)

  # 特別なアイコン(ONOKO様専用)
  create(name: "onoko", secret: true, special: true)

  class << self
    def icons
      where(special: false, secret: false)
    end

    def secret_icons
      where(special: false, secret: true)
    end

    def special_icon?(icon)
      find_by(name: icon).try(:special)
    end
  end

  def url
    "/images/icon/#{name}.png"
  end
end
