# frozen_string_literal: true

class ParticipantMailer < ApplicationMailer
  layout 'mailer'
  default template_path: "mailers/#{mailer_name}"

  def abstract_registration_mailer
    @participant = params[:participant]

    recipient = @participant.email

    mail(to: recipient, subject: 'Pendaftaran Peserta Abstrak Konferensi Nasional Kesehatan Reproduksi: Peluncuran Knowledge Hub dan Forum Ilmiah Tahunan IAKMI IV')
  end

  def seminar_registration_mailer
    @participant = params[:participant]

    @participant.data['seminar_email'] = true
    @participant.save

    recipient = @participant.email

    mail(to: recipient, subject: 'Pendaftaran Peserta Seminar Konferensi Nasional Kesehatan Reproduksi: Peluncuran Knowledge Hub dan Forum Ilmiah Tahunan IAKMI IV')
  end

  def oral_accepted_mailer
    @participant = params[:participant]
    @url = participant_menu_conferences_url(locale: 'id', slug: @participant.slug)

    recipient = @participant.email

    mail(to: recipient, subject: 'Pengumuman Abstrak Seminar Konferensi Nasional Kesehatan Reproduksi: Peluncuran Knowledge Hub dan Forum Ilmiah Tahunan IAKMI IV')
  end

  def poster_accepted_mailer
    @participant = params[:participant]
    @url = participant_menu_conferences_url(locale: 'id', slug: @participant.slug)

    recipient = @participant.email

    mail(to: recipient, subject: 'Pengumuman Abstrak Seminar Konferensi Nasional Kesehatan Reproduksi: Peluncuran Knowledge Hub dan Forum Ilmiah Tahunan IAKMI IV')
  end

  def abstract_rejected_mailer
    @participant = params[:participant]
    @url = participant_menu_conferences_url(locale: 'id', slug: @participant.slug)

    recipient = @participant.email

    mail(to: recipient, subject: 'Pengumuman Abstrak Seminar Konferensi Nasional Kesehatan Reproduksi: Peluncuran Knowledge Hub dan Forum Ilmiah Tahunan IAKMI IV')
  end
end
