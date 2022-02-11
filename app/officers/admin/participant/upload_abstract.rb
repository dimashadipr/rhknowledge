# frozen_string_literal: true

module Admin
  module Participant
    class UploadAbstract
      attr_reader :participant, :params, :current_user

      def initialize(participant, params, current_user)
        @participant  = participant
        @params       = params
        @current_user = current_user
      end

      def perform
        # void latest_abstract_file
        void_latest_abstract

        abstract_file                = AbstractFile.new
        abstract_file.participant_id = participant.id
        abstract_file.status         = 'submitted'
        abstract_file.save!

        abstract_file.file = params[:abstract]
        abstract_file.save!

        message = 'Upload File Asbtrak oleh Admin'
        Admin::Participant::Logger.new(participant, message, params, current_user, 1, {}, abstract_file).perform

        assign_reviewer(abstract_file) if participant.category_number.present?

        true
      end

      def void_latest_abstract
        latest_abstract_file = participant.latest_abstract_file
        return if latest_abstract_file.blank?

        latest_abstract_file.status = 'void'
        latest_abstract_file.save!

        # void review
        reviews = latest_abstract_file.participant_file_reviews
        reviews.each do |review|
          review.status = 'void'
          review.save!
        end
      end

      def assign_reviewer(abstract_file)
        reviewers = ParticipantFileReview::ABSTRACT_REVIEWER

        reviewers.each do |data|
          topics = data[:topic]
          next unless topics.include?(participant.category_number.to_i)

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
  end
end
