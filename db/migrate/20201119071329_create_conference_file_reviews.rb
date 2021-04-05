class CreateConferenceFileReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :conference_file_reviews do |t|
      t.references  :conference, index: true, foreign_key: true
      t.string      :category
      t.string      :code
      t.string      :description
      t.string      :option
      t.jsonb       :data, default: {}
      t.datetime    :deleted_at
      t.timestamps
    end
  end
end
