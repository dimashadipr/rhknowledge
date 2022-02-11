# frozen_string_literal: true

module Admin
  module Participant
    class ReviewAssigner
      attr_reader :participant, :params, :current_user

      def initialize(participant, params, current_user)
        @participant  = participant
        @params       = params
        @current_user = current_user
      end

      def perform
        user_ids = params[:reviewer_ids].reject(&:blank?)
        # update latest_abstract_file to in review
        latest_abstract_file.status = 'in_review'
        latest_abstract_file.save!
        # insert into participant_file_reviews
        user_ids.each do |user_id|
          user = User.find user_id

          review = ParticipantFileReview.find_or_initialize_by(
            user_id: user_id,
            participant_file_id: latest_abstract_file.id
          )

          review.status           = 'submitted' if review.new_record?
          review.created_by       = current_user.id
          review.save!

          message = "Assign Reviewer #{user.name} oleh #{current_user.name}"
          Admin::Participant::Logger.new(participant, message, params, current_user, 0, {}, review).perform
        end

        # remove file review not included
        obsolete_record = ParticipantFileReview.where(participant_file_id: latest_abstract_file.id)
                                               .where.not(user_id: user_ids)
        obsolete_record.each do |pfr|
          user = pfr.user
          message = "Hapus Reviewer #{user.name} oleh #{current_user.name}"
          Admin::Participant::Logger.new(participant, message, params, current_user, 0, {}, pfr).perform

          pfr.destroy
        end

        message = 'Sedang Di Review'
        Admin::Participant::Logger.new(participant, message, params, current_user, 0, {}, latest_abstract_file).perform

        true
      end

      def latest_abstract_file
        @latest_abstract_file ||= begin
          return participant.latest_abstract_file if participant.latest_abstract_file.present?

          # copy abstract to latest_abstract_file
          abstract             = AbstractFile.new
          abstract.participant = participant
          abstract.file        = participant.abstract
          abstract.status      = 'submitted'
          abstract.save

          abstract
        end
      end
    end
  end
end
