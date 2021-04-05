class CreateParticipantReviewScores < ActiveRecord::Migration[6.0]
  def change
    create_table :participant_review_scores do |t|
      t.references :participant_file_reviews, foreign_key: true
      t.string     :category
      t.integer    :score
      t.datetime   :deleted_at
      t.timestamps
    end
  end
end
