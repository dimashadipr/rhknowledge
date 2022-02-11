# frozen_string_literal: true

class Admin::ConferenceParticipantsController < AdminController
  def select_options
    conference_participants = ConferenceParticipant.search(params)

    result = conference_participants.map { |e| {id: e.id, category: e.category} }

    render json: result
  end
end
