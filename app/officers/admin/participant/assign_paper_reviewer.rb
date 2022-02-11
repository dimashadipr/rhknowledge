# frozen_string_literal: true

module Admin
  module Participant
    class AssignPaperReviewer
      attr_reader :participant, :params, :current_user

      def initialize(participant, params, current_user)
        @participant  = participant
        @params       = params
        @current_user = current_user
      end

      def perform
        user_ids = params[:reviewer_ids].reject(&:blank?)
        # update paper_file to in review
        paper_file.status = 'in_review'
        paper_file.save!
        # insert into participant_file_reviews
        user_ids.each do |user_id|
          user = User.find user_id

          review = ParticipantFileReview.find_or_initialize_by(
            user_id: user_id,
            participant_file_id: paper_file.id
          )

          review.status           = 'submitted' if review.new_record?
          review.created_by       = current_user.id
          review.save!

          message = "Assign Reviewer #{user.name} oleh #{current_user.name}"
          Admin::Participant::Logger.new(participant, message, params, current_user, 0, {}, review).perform
        end

        # remove file review not included
        obsolete_record = ParticipantFileReview.where(participant_file_id: paper_file.id)
                                               .where.not(user_id: user_ids)
        obsolete_record.each do |pfr|
          user = pfr.user
          message = "Hapus Reviewer #{user.name} oleh #{current_user.name}"
          Admin::Participant::Logger.new(participant, message, params, current_user, 0, {}, pfr).perform

          pfr.destroy
        end

        message = 'Sedang Di Review'
        Admin::Participant::Logger.new(participant, message, params, current_user, 0, {}, paper_file).perform

        true
      end

      def paper_file
        @paper_file = participant.paper_file
      end
    end
  end
end
