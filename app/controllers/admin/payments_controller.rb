# frozen_string_literal: true

class Admin::PaymentsController < AdminController
  before_action :prepare_payment, only: %i[edit update]

  def index
    authorize! :read, 'payment'

    params[:search] = {} if params[:search].blank?

    @payments = PaymentFile.search(params[:search])
                           .page(params[:page])
                           .per(25)
                           .order(created_at: :asc)
  end

  def edit
    authorize! :update, 'payment'

    @status = params[:status]
    @klass  = 'bg-success'
    @klass  = 'bg-danger' if params[:status] != 'accepted'
  end

  def update
    authorize! :update, 'payment'

    ActiveRecord::Base.transaction do
      officer = Admin::Participant::PaymentChecker.new(@payment, current_user, params)

      if officer.perform
        @payment.reload

        flash[:success] = "Success #{params[:status].humanize}"
        # TODO: SEND EMAAIl
        if @payment.status == 'accepted'
          ParticipantPaymentMailer.with(payment_file: @payment).accepted.deliver_later
        else
          ParticipantPaymentMailer.with(payment_file: @payment).rejected.deliver_later
        end
      else
        flash[:error] = "Failed #{params[:status].humanize}"
        raise ActiveRecord::Rollback
      end
    end

    redirect_to admin_payments_path
  end

  private

  def prepare_payment
    @payment = PaymentFile.find params[:id]
  end
end
