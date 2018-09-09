class Icon < ActiveHash::Base
  include SupportActiveHash

  field :name
  field :secret
  field :special

  168.times do |i|
    id = i + 1
    create(name: "icon_#{id}", secret: false, special: false)
  end

  # シークレットアイコン
  create(name: "n-suke", secret: true, special: false)
  create(name: "oda", secret: true, special: false)
  create(name: "suika", secret: true, special: false)
  create(name: "t-yan", secret: true, special: false)
  create(name: "yoshio", secret: true, special: false)
  create(name: "yoshio_true", secret: true, special: false)

  # 特別なアイコン(ONOKO様専用)
  create(name: "onoko", secret: true, special: true)

  class << self
    def icons
      where(special: false)
    end

    def special_icon?(icon)
      find_by(name: icon).try(:special)
    end
  end

  def icon_class(current_user)
    class_arr = %w[color icon]
    class_arr << "selected" if current_user && current_user.icon == name
    class_arr << "secret" if secret
    class_arr.join(" ")
  end

  def url
    "/images/icon/#{name}.png"
  end
end
