# frozen_string_literal: true

class Admin::ConferencesController < AdminController
  before_action :prepare_conference, only: %i[edit update destroy get_speakers]

  def index
    authorize! :read, 'conference'

    @conferences = Conference.order(created_at: :desc).page(params[:page]).per(15)
  end

  def new
    authorize! :create, 'conference'

    @conference = Conference.new
  end

  def create
    authorize! :create, 'conference'

    ActiveRecord::Base.transaction do
      @conference = ConferenceOfficer.new conference_params

      if @conference.perform
        flash[:success] = 'Success Add New Conference'
        redirect_to admin_conferences_path
      else
        flash[:error] = 'Failed to Add New Conference'
      end
    end

  end

  def edit
    authorize! :update, 'conference'
  end

  def update
    authorize! :update, 'conference'

    ActiveRecord::Base.transaction do
      @conference = ConferenceOfficer.new conference_params

      if @conference.perform
        flash[:success] = 'Success Update Conference'
        redirect_to admin_conferences_path
      else
        flash[:error] = 'Failed to Update Conference'
      end
    end
  end

  def destroy
    authorize! :delete, 'conference'

    if @conference.destroy!
      flash[:success] = 'Success Delete Conference'
    else
      flash[:error] = 'Failed Delete Conference'
    end
    redirect_to admin_conferences_path
  end

  def get_speakers
    authorize! :create, 'conference'
  end

  def manage_speakers
    authorize! :create, 'conference'
    # officer save speakersActiveRecord::Base.transaction do

    @conference = ManageSpeakerOfficer.new params[:id], speaker_params

    if @conference.perform
      flash[:success] = 'Success Update Speakers'
      redirect_to admin_conferences_path
    else
      flash[:error] = 'Failed to Update Speakers'
    end
  end

  private

  def conference_params
    params[:conference].permit(:id, :name, :status, :start_time ,:end_time, conference_registration: {}, conference_banner: {}, conference_quick_links: {}, conference_participants: {}, conference_topics: {})
  end

  def speaker_params
    params[:conference].permit(conference_letters: {}, conference_speakers: {})
  end

  def prepare_conference
    @conference = Conference.find params[:id]
  end
end
