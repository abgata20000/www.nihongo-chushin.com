module UserIconSupportable
  extend ActiveSupport::Concern

  def color_class
    "color_#{color}"
  end

  def icon_url
    "/images/icon/#{icon}.png"
  end
end
