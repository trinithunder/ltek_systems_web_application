# app/services/email_service.rb

class EmailService
  def initialize
    @mailer = ApplicationMailer
  end

  def send_email(to:, subject:, body:)
    @mailer.mail(to: to, subject: subject, body: body).deliver_now
  end
end
