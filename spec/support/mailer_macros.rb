module MailerMacros
  def last_email
    ActionMailer::Base.deliveries.last
  end

  def sent_email_count
    ActionMailer::Base.deliveries.size
  end

  def reset_email
    ActionMailer::Base.deliveries = []
  end
end
