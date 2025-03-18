# app/controllers/concerns/email_service_concern.rb

module EmailServiceConcern
  extend ActiveSupport::Concern

  def email_service
    @email_service ||= EmailService.new
  end
end
