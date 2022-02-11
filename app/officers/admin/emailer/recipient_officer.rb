# frozen_string_literal: true

module Admin
  module Emailer
    class RecipientOfficer
      attr_reader :mailer, :params
      def initialize(mailer, params)
        @mailer = mailer
        @params = params
      end

      def perform
        recipients.each do |email|
          status = 'submitted'
          status = 'invalid' unless valid_email?(email)

          mailer_recipient        = MailerRecipient.new
          mailer_recipient.mailer = mailer
          mailer_recipient.email  = email
          mailer_recipient.status = status
          mailer_recipient.save!
        end
      end

      def recipient_type
        params[:recipient_type]
      end

      def recipients
        return params[:recipient_list].reject!(&:blank?) if recipient_type == 'regular'

        conference_recipient
      end

      def conference_recipient
        @conference_recipient ||= begin
          result = ::Participant.search(search_params)
          participant_ids = params[:participant_id].reject!(&:blank?)
          result = result.where(id: participant_ids) unless participant_ids.blank?

          result.map(&:email)
        end
      end

      private

      def valid_email?(email)
        email =~ URI::MailTo::EMAIL_REGEXP
      end

      def search_params
        conference_id = params[:conference_id]
        conference_participant_ids = params[:conference_participant_id].reject!(&:blank?)
        conference_topic_ids = params[:conference_topic_id].reject!(&:blank?)
        {
          conference_id: conference_id,
          conference_participant_id: conference_participant_ids,
          conference_topic_id: conference_topic_ids
        }
      end
    end
  end
end
