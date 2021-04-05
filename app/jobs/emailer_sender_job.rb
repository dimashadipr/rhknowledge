class EmailerSenderJob < ApplicationJob
  queue_as :default

  def perform(mailer_id)
    Admin::Emailer::Sender.new(mailer_id).perform
  end
end
