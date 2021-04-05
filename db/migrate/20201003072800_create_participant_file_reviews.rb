class CreateParticipantFileReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :participant_file_reviews do |t|
      t.references :participant_file, foreign_key: true
      t.references :user, foreign_key: true
      t.string     :status
      t.string     :note
      t.datetime   :deleted_at
      t.timestamps
    end
  end
end
