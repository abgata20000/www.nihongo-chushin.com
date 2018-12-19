class ActiveTypeRecord < ActiveType::Object
  def show_attributes
    attributes
  end

  { errors: errors.full_messages }
end
