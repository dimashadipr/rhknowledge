class AddConferenceFileReviewToReviewScore < ActiveRecord::Migration[6.0]
  def change
    add_reference :participant_review_scores, :conference_file_review, index: true, foreign_key: true, default: nil
  end
end
