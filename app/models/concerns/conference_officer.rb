# frozen_string_literal: true

class ConferenceOfficer
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def perform
    manage_conference

    manage_conference_registration

    manage_conference_banner

    manage_conference_quick_links

    manage_conference_participants

    manage_conference_topics
  end

  def manage_conference
    @conference = Conference.find_or_initialize_by(id: params[:id])

    status = if params[:status].to_i == 1
               :active
             else
               :inactive
             end

    @conference.name = params[:name]
    @conference.status = status
    @conference.start_time = params[:start_time]
    @conference.end_time = params[:end_time]

    @conference.save!
  end

  def manage_conference_registration
    return if params[:conference_registration].blank?

    conference_registration = ConferenceRegistration.find_or_initialize_by(conference_id: @conference.id)

    conference_registration.start_time = params[:conference_registration][:start_time]
    conference_registration.end_time   = params[:conference_registration][:end_time]

    conference_registration.save!
  end

  def manage_conference_banner
    return if params[:conference_banner].blank?

    conference_banner = ConferenceBanner.find_or_initialize_by(conference_id: @conference.id)

    conference_banner.image = params[:conference_banner][:image] if params[:conference_banner][:image].present?

    conference_banner.save!
  end

  def manage_conference_quick_links
    return if params[:conference_quick_links].blank?

    params[:conference_quick_links].each do |_index, param_quick_link|
      if param_quick_link[:deleted] == 'true'
        ConferenceQuickLink.find(param_quick_link[:id]).destroy if param_quick_link[:id].present?
        next
      end

      conference_quick_link = ConferenceQuickLink.find_or_initialize_by(conference_id: @conference.id, id: param_quick_link[:id])
      conference_quick_link = ConferenceQuickLink.find(param_quick_link[:id]) if param_quick_link[:id].present?
      conference_quick_link.label      = param_quick_link[:label]
      conference_quick_link.position   = param_quick_link[:position]
      conference_quick_link.image      = param_quick_link[:image] if param_quick_link[:image].present?
      conference_quick_link.file       = param_quick_link[:file] if param_quick_link[:file].present?
      conference_quick_link.save
    end
  end

  def manage_conference_participants
    return if params[:conference_participants].blank?

    params[:conference_participants].each do |_index, param_participant|
      if param_participant[:deleted] == 'true'
        ConferenceParticipant.find(param_participant[:id]).destroy if param_participant[:id].present?
        next
      end

      conference_participant = ConferenceParticipant.find_or_initialize_by(conference_id: @conference.id, id: param_participant[:id])
      conference_participant = ConferenceParticipant.find(param_participant[:id]) if param_participant[:id].present?

      conference_participant.category     = param_participant[:category]
      conference_participant.start_time   = param_participant[:start_time] if param_participant[:start_time].present?
      conference_participant.end_time     = param_participant[:end_time] if param_participant[:end_time].present?
      conference_participant.save
    end
  end

  def manage_conference_topics
    return if params[:conference_topics].blank?

    params[:conference_topics].each do |_index, param_topic|
      if param_topic[:deleted] == 'true'
        ConferenceTopic.find(param_topic[:id]).destroy if param_topic[:id].present?
        next
      end

      conference_topic = ConferenceTopic.find_or_initialize_by(conference_id: @conference.id, id: param_topic[:id])
      conference_topic = ConferenceTopic.find(param_topic[:id]) if param_topic[:id].present?

      conference_topic.name = param_topic[:name]
      conference_topic.save
    end
  end
end
