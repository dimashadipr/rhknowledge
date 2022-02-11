# frozen_string_literal: true

module Conferences
  class UploadPayment
    attr_reader :participant, :params, :errors
    def initialize(participant, params)
      @participant = participant
      @params      = params
      @errors      = ''
    end

    def perform
      # checker
      if participant.payment_file.present?
        @errors = 'Payment Proof Already Exist'
        return false
      end

      file_payment                     = PaymentFile.new
      file_payment.participant         = participant
      file_payment.data['sender_bank'] = params[:sender_bank]
      file_payment.file                = params[:proof]
      file_payment.status              = 'submitted'
      file_payment.save!

      # update participant
      participant.data['sender_bank'] = params[:sender_bank]
      participant.save!

      # log
      message = 'Upload Bukti Pembayaran'
      Admin::Participant::Logger.new(participant, message, params, nil, 1, {}, file_payment).perform

      true
    end
  end
end
