# frozen_string_literal: true

class CustomEmailMailer < ApplicationMailer
  layout 'mailer'
  default template_path: "mailers/#{mailer_name}"

  ERRORS_TO_RESCUE = [
    Net::SMTPAuthenticationError,
    Net::SMTPServerBusy,
    Net::SMTPSyntaxError,
    Net::SMTPFatalError,
    Net::SMTPUnknownError,
    StandardError,
    NameError,
    Errno::ECONNREFUSED
  ].freeze

  def custom_mailer
    recipient_id = params[:recipient_id]
    recipient    = params[:recipient]
    subject      = params[:subject]
    @content     = params[:content]

    recp = MailerRecipient.find_by id: recipient_id
    recp.status = 'sent'
    recp.save

    mailer = recp.mailer
    success = mailer.mailer_recipients.all?(&:sent?)
    if success
      mailer.status = 'sent'
      mailer.save
    end

    mail(to: recipient, subject: subject)
  end

  rescue_from(*ERRORS_TO_RESCUE) do |exception|
    # Handle it here
    # Rollbar.error(exception, params: params)

    recipient_id = params[:recipient_id]
    recp = MailerRecipient.find_by id: recipient_id
    recp.status = 'failed'
    recp.data['error'] = exception.message
    recp.save

    mailer = recp.mailer
    success = mailer.mailer_recipients.all?(&:sent?)
    if success
      mailer.status = 'sent'
      mailer.save
    end
  end
end
