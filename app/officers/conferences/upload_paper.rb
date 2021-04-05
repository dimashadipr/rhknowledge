# frozen_string_literal: true

module Conferences
  class UploadPaper
    attr_reader :participant, :params, :errors
    def initialize(participant, params)
      @participant = participant
      @params      = params
      @errors      = ''
    end

    def perform
      # checker
      if participant.paper_file.present?
        @errors = 'Paper File Already Exist'
        return false
      end

      file_paper                   = PaperFile.new
      file_paper.participant       = participant
      file_paper.data['title']     = params[:title]
      file_paper.data['presenter'] = params[:presenter]
      file_paper.file              = params[:paper]
      file_paper.status            = 'submitted'
      file_paper.save!

      # update participant
      participant.data['paper_title'] = params[:title]
      participant.data['presenter']   = params[:presenter]
      participant.save!

      # log
      message = "Upload File Paper: #{params[:title]}"
      Admin::Participant::Logger.new(participant, message, params, nil, 1, {}, file_paper).perform

      true
    end
  end
end
