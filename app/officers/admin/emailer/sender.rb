# frozen_string_literal: true

module Admin
  module Emailer
    class Sender
      attr_reader :mailer

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

      def initialize(mailer_id)
        @mailer = Mailer.find_by id: mailer_id
      end

      def perform
        return false if mailer.blank?

        return false unless mailer.send?

        mailer.status = 'sending'
        mailer.save

        mailer_recipients.each_with_index do |recipient, index|
          next unless recipient.send?

          recipient.status = 'sending'
          recipient.save

          wait = index
          wait = index * 2 if index > 1 && index.odd?

          CustomMailerJob.set(wait: wait.seconds).perform_later(mailer, recipient)
        end
      rescue *ERRORS_TO_RESCUE
        # Handle it here
        mailer.status = 'failed'
        mailer.save
      end

      def mailer_recipients
        @mailer_recipients ||= mailer.mailer_recipients
      end
    end
  end
end
