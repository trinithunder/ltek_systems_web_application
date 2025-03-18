# app/controllers/mail_controller.rb

class MailController < ApplicationController
  def send_test_email
    to = params[:to]
    subject = params[:subject]
    body = params[:body]

    if email_service.send_email(to: to, subject: subject, body: body)
      render json: { message: 'Email sent successfully' }, status: :ok
    else
      render json: { message: 'Email failed to send' }, status: :unprocessable_entity
    end
  end
end
