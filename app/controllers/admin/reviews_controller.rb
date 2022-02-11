# frozen_string_literal: true

class Admin::ReviewsController < AdminController
  before_action :prepare_review, only: %i[edit update]

  def index
    authorize! :read, 'review'

    params[:search] = {} if params[:search].blank?
    params[:search][:status] = 'submitted' if params[:search][:status].blank?

    if current_user.reviewer?
      params[:search][:user_id] = current_user.id
    end

    @reviews = ParticipantFileReview.search(params[:search])
                                    .page(params[:page])
                                    .per(25)
                                    .order(created_at: :asc)
  end

  def edit
    authorize! :update, 'review'

    # TODO: get conference
    conference = Conference.first
    @conference_file_reviews = conference.paper_reviews
  end

  def update
    authorize! :update, 'review'

    ActiveRecord::Base.transaction do
      if @participant_file.type == 'AbstractFile'
        officer = Admin::Participant::AbstractReviewer.new(@review, current_user, params)
      else
        officer = Admin::Participant::PaperReviewer.new(@review, current_user, params)
      end
      if officer.perform
        flash[:success] = 'Success to Proceed'
      else
        flash[:error] = 'Failed to Proceed'
        raise ActiveRecord::Rollback
      end
    end

    redirect_to admin_reviews_path
  end

  private

  def prepare_review
    @review = ParticipantFileReview.find params[:id]
    @participant_file = @review.participant_file
  end
end
