# frozen_string_literal: true

class ManageSpeakerOfficer
  attr_reader :params

  def initialize(id, params)
    @id       = id
    @params   = params
  end

  def perform
    manage_conference_letters

    manage_conference_speakers
  end

  def manage_conference_letters
    return if params[:conference_letters].blank?

    params[:conference_letters].each do |_index, param_letter|
      if param_letter[:deleted] == 'true'
        ConferenceLetter.find(param_letter[:id]).destroy if param_letter[:id].present?
        next
      end

      conference_participant = ConferenceLetter.find_or_initialize_by(conference_id: @id, id: param_letter[:id])
      conference_participant = ConferenceLetter.find(param_letter[:id]) if param_letter[:id].present?

      conference_participant.name         = param_letter[:name]
      conference_participant.title        = param_letter[:title]
      conference_participant.message      = param_letter[:message]
      conference_participant.image        = param_letter[:image] if param_letter[:image].present?
      conference_participant.position     = param_letter[:position]
      conference_participant.save
    end
  end

  def manage_conference_speakers
    return if params[:conference_speakers].blank?

    params[:conference_speakers].each do |_index, param_speaker|
      if param_speaker[:deleted] == 'true'
        ConferenceSpeaker.find(param_speaker[:id]).destroy if param_speaker[:id].present?
        next
      end

      conference_participant = ConferenceSpeaker.find_or_initialize_by(conference_id: @id, id: param_speaker[:id])
      conference_participant = ConferenceSpeaker.find(param_speaker[:id]) if param_speaker[:id].present?

      conference_participant.name                = param_speaker[:name]
      conference_participant.title               = param_speaker[:title]
      conference_participant.image               = param_speaker[:image] if param_speaker[:image].present?
      conference_participant.position            = param_speaker[:position]
      conference_participant.group               = param_speaker[:group]
      conference_participant.conference_position = param_speaker[:conference_position]
      conference_participant.save
    end
  end
end
