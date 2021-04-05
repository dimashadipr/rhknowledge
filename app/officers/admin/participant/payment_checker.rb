# frozen_string_literal: true

module Admin
  module Participant
    class PaymentChecker
      attr_reader :payment_file, :current_user, :params

      def initialize(payment_file, current_user, params)
        @payment_file = payment_file
        @current_user = current_user
        @params       = params
      end

      def perform
        message = "Update Status Payment #{params[:status]}"
        Admin::Participant::Logger.new(participant, message, params, current_user, 1, {}, payment_file).perform

        # update status payment file
        payment_file.status                 = params[:status]
        payment_file.data['approved_by']    = current_user.id
        if params[:status] == 'accepted'
          payment_file.data['invoice_number'] = invoice_number

          participant.data['number'] = PaymentFile.generate_participant_number
          participant.save!
        end
        payment_file.save!
      end

      def participant
        @participant ||= payment_file.participant
      end

      def invoice_number
        @invoice_number ||= PaymentFile.generate_invoice_number
      end
    end
  end
end
