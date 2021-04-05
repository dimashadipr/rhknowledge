# frozen_string_literal: true

class Admin::ParticipantsController < AdminController
  before_action :prepare_participant, only: %i[modal_assign_reviewer assign_reviewer modal_final_review final_review modal_upload_abstract upload_abstract destroy modal_reviewer_paper reviewer_paper]
  before_action :prepare_modal_reviewer, only: %i[modal_assign_reviewer modal_reviewer_paper]

  def index
    authorize! :read, 'participant'

    params[:search] = {} if params[:search].blank?

    @participant_options = ConferenceParticipant.all.map { |e| [e.category, e.id] }

    @participants = Participant.preload(:latest_abstract_file, :paper_file, :payment_file, :presentation_file)
                               .search(params[:search])
                               .page(params[:page])
                               .per(25)
                               .order(created_at: :desc)
  end

  def modal_assign_reviewer
    authorize! :assign_reviewer, 'participant'

    latest_abstract_file     = @participant.latest_abstract_file
    participant_file_reviews = latest_abstract_file.participant_file_reviews

    @user_ids = participant_file_reviews.map(&:user_id)
  end

  def assign_reviewer
    authorize! :assign_reviewer, 'participant'

    ActiveRecord::Base.transaction do
      officer = Admin::Participant::ReviewAssigner.new(@participant, params, current_user)
      if officer.perform
        flash[:success] = 'Success Assign reviewer'
      else
        flash[:error] = 'Failed Assign reviewer'
        raise ActiveRecord::Rollback
      end
    end

    redirect_to admin_participants_path
  end

  def modal_reviewer_paper
    authorize! :assign_reviewer, 'participant'

    paper_file               = @participant.paper_file
    participant_file_reviews = paper_file.participant_file_reviews

    @user_ids = participant_file_reviews.map(&:user_id)
  end

  def reviewer_paper
    authorize! :assign_reviewer, 'participant'

    ActiveRecord::Base.transaction do
      officer = Admin::Participant::AssignPaperReviewer.new(@participant, params, current_user)
      if officer.perform
        flash[:success] = 'Success Assign reviewer'
      else
        flash[:error] = 'Failed Assign reviewer'
        raise ActiveRecord::Rollback
      end
    end

    redirect_to admin_participants_path
  end

  def modal_final_review
    authorize! :final_review, 'participant'
  end

  def final_review
    authorize! :final_review, 'participant'

    ActiveRecord::Base.transaction do
      officer = Admin::Participant::FinalReviewer.new(@participant, params, current_user)
      if officer.perform
        flash[:success] = 'Success Review'

        @participant.reload

        latest_abstract_file = @participant.latest_abstract_file
        case latest_abstract_file.status
        when 'oral_accepted'
          ParticipantMailer.with(participant: @participant).oral_accepted_mailer.deliver_later
        when 'poster_accepted'
          ParticipantMailer.with(participant: @participant).poster_accepted_mailer.deliver_later
        when 'rejected'
          ParticipantMailer.with(participant: @participant).abstract_rejected_mailer.deliver_later
        end
      else
        flash[:error] = 'Failed Review'
        raise ActiveRecord::Rollback
      end
    end

    redirect_to admin_participants_path
  end

  def modal_upload_abstract
    authorize! :upload_abstract, 'participant'
  end

  def upload_abstract
    authorize! :upload_abstract, 'participant'

    officer = Admin::Participant::UploadAbstract.new(@participant, params, current_user)
    if officer.perform
      flash[:success] = 'Success Upload Abstract'
    else
      flash[:error] = 'Failed Upload Abstract'
    end

    redirect_to admin_participants_path
  end

  def destroy
    authorize! :delete, 'participant'

    if @participant.destroy!
      flash[:success] = 'Success Delete Participant'
    else
      flash[:error] = 'Failed Delete Participant'
    end
    redirect_to admin_participants_path
  end

  def select_options
    participant = Participant.search(params)

    result = participant.map { |e| { id: e.id, full_name: e.full_name, email: e.email } }

    render json: result
  end

  private

  def prepare_modal_reviewer
    @reviewer_options = UserAdmin.reviewer_options
  end

  def prepare_participant
    @participant = Participant.find params[:id]
  end
end
