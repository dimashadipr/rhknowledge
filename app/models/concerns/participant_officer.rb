# frozen_string_literal: true

class ParticipantOfficer
  attr_reader :params, :errors

  def initialize(params)
    @params = params
    @errors = nil
  end

  def perform
    unless conference.active_registration?
      @errors = 'Waktu Pendaftaran Belum Dibuka'
      return false
    end

    if exist?
      @errors = 'Email telah didaftarkan'
      return false
    end

    if conference_participant.disabled?
      @errors = 'Waktu Pendaftaran Peserta telah ditutup'
      return false
    end

    participant.data['scholarship'] = true if params[:scholarship].to_i != 0

    participant.abstract = nil

    # sanitize topic
    if topic.present?
      participant.topic = topic.name
      participant.data['category_number'] = topic.id
    end

    # sanitize participant
    participant.participant = conference_participant.category

    participant.slug = slug
    participant.save!

    # save abstract_file
    if params[:abstract].present?
      abstract_file                = AbstractFile.new
      abstract_file.participant_id = participant.id
      abstract_file.file           = params[:abstract]
      abstract_file.status         = 'submitted'
      abstract_file.save!

      logger(participant, abstract_file)

      assign_reviewer(participant, abstract_file)
    end

    true
  end

  def participant
    @participant ||= Participant.new params.except(:scholarship)
  end

  def slug
    @slug ||= SecureRandom.hex
  end

  def exist?
    Participant.find_by(conference_id: conference.id, email: params[:email])
  end

  def conference
    @conference ||= Conference.find params[:conference_id]
  end

  def topic
    @topic ||= ConferenceTopic.find_by id: params[:conference_topic_id]
  end

  def conference_participant
    @conference_participant ||= ConferenceParticipant.find params[:conference_participant_id]
  end

  def logger(participant, abstract_file)
    message = 'Terdaftar'
    Admin::Participant::Logger.new(participant, message, params, nil, 1, {}, participant).perform
    message = 'Upload File Asbtrak'
    Admin::Participant::Logger.new(participant, message, params, nil, 1, {}, abstract_file).perform
  end

  def assign_reviewer(participant, abstract_file)
    reviewers = ParticipantFileReview::ABSTRACT_REVIEWER

    reviewers.each do |data|
      topics = data[:topic]
      next unless topics.include?(participant.data['category_number'].to_i)

      user = User.find_by email: data[:email]
      review = ParticipantFileReview.new
      review.participant_file = abstract_file
      review.user_id          = user.id
      review.status           = 'submitted'
      review.created_by       = nil
      review.save!

      message = "Assign Reviewer #{user.name} oleh Sistem"
      Admin::Participant::Logger.new(participant, message, params, nil, 0, {}, review).perform
    end

    abstract_file.reload

    return if abstract_file.participant_file_reviews.empty?

    abstract_file.status = 'in_review'
    abstract_file.save

    message = 'Sedang Di Review'
    Admin::Participant::Logger.new(participant, message, params, nil, 0, {}, abstract_file).perform
  end
end
