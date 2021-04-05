module Admin
  module Emailer
    class Creator
      attr_reader :params, :current_user, :error

      def initialize(params, current_user)
        @params       = params
        @current_user = current_user
        @error        = nil
      end

      def perform
        if empty_content?
          @error = 'Content cannot be empty'
          return false
        end

        # create mailer recipient
        ActiveRecord::Base.transaction do
          Admin::Emailer::RecipientOfficer.new(mailer, params).perform
        end
        true
      rescue StandardError => e
        @error = e.message
        false
      end

      def slug
        @slug ||= SecureRandom.hex
      end

      def empty_content?
        params[:content].blank?
      end

      def mailer
        @mailer ||= begin
          mailer         = Mailer.new
          mailer.user    = current_user
          mailer.status  = 'submitted'
          mailer.subject = params[:subject]
          mailer.slug    = slug
          mailer.content = params[:content]
          mailer.save!

          mailer
        end
      end
    end
  end
end
