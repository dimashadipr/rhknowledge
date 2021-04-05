# frozen_string_literal: true

class ConferencesController < WebController
  before_action :prepare_data, only: [:index]

  def index; end

  def create
    officer = ParticipantOfficer.new(participant_params)
    if officer.perform
      @participant = officer.participant
      if @participant.latest_abstract_file.present?
        ParticipantMailer.with(participant: @participant).abstract_registration_mailer.deliver_later
      else
        ParticipantMailer.with(participant: @participant).seminar_registration_mailer.deliver_later
      end

      render 'success', layout: false
    else
      errors = 'Gagal Registrasi'
      errors = officer.errors if officer.errors.present?

      flash[:error] = errors
      redirect_to conferences_path(anchor: 'registration')
    end
  end

  def download_tor
    send_file("#{Rails.root}/public/tor.pdf", filename: 'TOR FIT VI & Peluncuran KHRH.pdf')
  end

  def download_guide
    send_file("#{Rails.root}/public/guideline.pdf", filename: 'Ketentuan Pengiriman Abstrak FIT IAKMI VI dan Peluncuran Knowledge Hub.pdf')
  end

  def download_faq
    send_file("#{Rails.root}/public/faq.pdf", filename: 'FAQ FIT IAKMI VI dan Peluncuran Knowledge Hub.pdf')
  end

  def download_schedule
    send_file("#{Rails.root}/public/schedule.pdf", filename: 'Handbook Peserta.pdf')
  end

  def participant_params
    params[:conferences].permit(:front_title, :back_title, :title, :name,
                                :email, :phone, :whatsapp, :institution,
                                :institution_phone, :conference_participant_id,
                                :conference_topic_id, :conference_id,
                                :scholarship, :abstract)
  end

  def prepare_data
    @conference          = Conference.first # TODO: get from URL
    @title_options       = %w[Bapak Ibu Saudara/i]
    @participant_options = @conference.participant_options
    @topic_options       = @conference.topic_options
    @speakers            = @conference.conference_speakers.sort_by(&:position)
  end
end
