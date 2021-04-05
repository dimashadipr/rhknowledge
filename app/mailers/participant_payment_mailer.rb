class ParticipantPaymentMailer < ApplicationMailer

  layout 'mailer'
  default template_path: "mailers/#{mailer_name}"

  include ApplicationHelper
  add_template_helper(ApplicationHelper)

  def accepted
    @payment_file = params[:payment_file]
    @participant = @payment_file.participant

    mail(to: @participant.email, subject: 'Verfikasi Bukti Pembayaran Abstrak')
  end

  def rejected
    @payment_file = params[:payment_file]
    @participant = @payment_file.participant
    @url = participant_menu_conferences_url(locale: 'id', slug: @participant.slug)

    mail(to: @participant.email, subject: 'Verfikasi Bukti Pembayaran Abstrak')
  end
end
