# frozen_string_literal: true

class Admin::ConferenceReportsController < AdminController
  def participant
    authorize! :read, 'conference_report'

    @participants = Participant.preload(:conference_participant, :conference_topic)

    if request.format.html?
      @participants = @participants.page(params[:page])
                                   .per(25)
    end

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def reviewer
    authorize! :read, 'conference_report'

    @participants = Participant.preload(latest_abstract_file: [participant_file_reviews: :user])
                               .preload(:conference_topic)
                               .where(conference_participant_id: [2, 3])
                               .order(created_at: :asc)

    if request.format.html?
      @participants = @participants.page(params[:page])
                                   .per(25)
    end

    respond_to do |format|
      format.html
      format.xlsx
    end
  end
end
