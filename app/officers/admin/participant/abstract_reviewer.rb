# frozen_string_literal: true

module Admin
  module Participant
    class AbstractReviewer
      attr_reader :file_review, :current_user, :params

      def initialize(file_review, current_user, params)
        @file_review  = file_review
        @current_user = current_user
        @params       = params
      end

      def perform
        # check user is same
        unless same_user?
          # change user_id
          # create logger if different
          change_user
        end

        total_score = 0
        params[:score].each do |_index, score|
          review_score                             = ParticipantReviewScore.new
          review_score.participant_file_reviews_id = file_review.id
          review_score.category                    = score[:criterion]
          review_score.score                       = score[:score].to_i
          review_score.save

          total_score += score[:score].to_i
        end

        # update file review
        if total_score <= 10
          status = 'rejectd'
        elsif total_score > 10 && total_score <= 15
          status = 'poster_recommended'
        elsif total_score > 15
          status = 'accepted'
        end

        file_review.user_id = current_user.id unless same_user?
        file_review.note    = params[:note] if params[:note].present?
        file_review.score   = total_score
        file_review.status  = status
        file_review.save!

        # update participant file if file reviews not submitted
        file_review.reload

        all_review_status = participant_file.participant_file_reviews.map(&:status)
        unless all_review_status.all? { |e| e == 'submitted' }
          participant_file.status = 'need_review'
          participant_file.save
        end

        true
      end

      def participant
        @participant ||= file_review.participant
      end

      def participant_file
        @participant_file ||= file_review.participant_file
      end

      private

      def same_user?
        file_review.user_id == current_user.id
      end

      def change_user
        message = "Take over Reviewer from #{file_review.user.name} to #{current_user.name}"
        Admin::Participant::Logger.new(participant, message, params, current_user, 0, {}, file_review).perform
      end
    end
  end
end
