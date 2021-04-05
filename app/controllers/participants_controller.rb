# frozen_string_literal: true

class ParticipantsController < WebController
  before_action :prepare_participant
  before_action :prepare_slug

  def show
    @slug = params[:slug]
  end

  def upload_paper
    ActiveRecord::Base.transaction do
      officer = Conferences::UploadPaper.new(@participant, params[:paper])
      unless officer.perform
        flash[:error] = officer.errors
        raise ActiveRecord::Rollback
      end
    end

    redirect_to participant_menu_conferences_path(slug: @slug)
  end

  def upload_payment
    ActiveRecord::Base.transaction do
      officer = Conferences::UploadPayment.new(@participant, params[:payment])
      unless officer.perform
        flash[:error] = officer.errors
        raise ActiveRecord::Rollback
      end
    end

    redirect_to participant_menu_conferences_path(slug: @slug)
  end

  def upload_presentation
    ActiveRecord::Base.transaction do
      officer = Conferences::UploadPresentation.new(@participant, params[:presentation])
      unless officer.perform
        flash[:error] = officer.errors
        raise ActiveRecord::Rollback
      end
    end

    redirect_to participant_menu_conferences_path(slug: @slug)
  end

  private

  def prepare_slug
    @slug = params[:slug]
  end

  def prepare_participant
    @participant = Participant.find_by slug: params[:slug]
  end
end
