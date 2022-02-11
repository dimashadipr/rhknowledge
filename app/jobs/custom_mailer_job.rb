class CustomMailerJob < ApplicationJob
  queue_as :default

  def perform(mailer, recipient)
    CustomEmailMailer.with(
      recipient_id: recipient.id,
      recipient: recipient.email,
      subject: mailer.subject,
      content: mailer.content
    ).custom_mailer.deliver_now
  end
end
