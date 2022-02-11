class CreateConferenceTopicReviewers < ActiveRecord::Migration[6.0]
  def change
    create_table :conference_topic_reviewers do |t|
      t.references  :conference_topic
      t.references  :user, foreign_key: true
      t.datetime    :deleted_at
      t.timestamps
    end
  end
end
