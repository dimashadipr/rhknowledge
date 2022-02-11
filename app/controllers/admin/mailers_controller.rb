# frozen_string_literal: true

class Admin::MailersController < AdminController
  before_action :prepare_form_data, only: %i[new create]

  def index
    authorize! :read, 'mailer'
    @mailers = Mailer.page(params[:page])
                     .per(25)
                     .order(created_at: :desc)
  end

  def new; end

  def show
    authorize! :read, 'mailer'
    @mailer = Mailer.find params[:id]
    @recipients = @mailer.mailer_recipients
                         .page(params[:page])
                         .per(50)
  end

  def create
    authorize! :create, 'mailer'

    officer = Admin::Emailer::Creator.new(params[:mailers], current_user)

    if officer.perform
      mailer_id = officer.mailer&.id
      EmailerSenderJob.perform_later(mailer_id)

      flash.now[:success] = 'Success create Mailer. Please Wait a moment to send all emails'
      redirect_to admin_mailers_path
    else
      error = officer.error
      flash.now[:error] = "Failed to create Mailer. #{error}"

      render 'new'
    end
  end

  def prepare_form_data
    @conference_options = Conference.all.map { |e| [e.name, e.id] }
  end
end
