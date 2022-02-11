# frozen_string_literal: true

module Conferences
  class UploadPresentation
    attr_reader :participant, :params, :errors
    def initialize(participant, params)
      @participant = participant
      @params      = params
      @errors      = ''
    end

    def perform
      # checker
      if participant.presentation_file.present?
        @errors = 'Presentation Already Exist'
        return false
      end

      file_presentation             = PresentationFile.new
      file_presentation.participant = participant
      file_presentation.status      = 'submitted'
      file_presentation.file        = params[:file]
      file_presentation.save!

      # update participant
      participant.data['sender_bank'] = params[:sender_bank]
      participant.save!

      # log
      message = 'Upload Dokumen Presentasi'
      Admin::Participant::Logger.new(participant, message, params, nil, 1, {}, file_presentation).perform

      true
    end
  end
end
