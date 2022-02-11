class CreateConferenceTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :conference_topics do |t|
      t.references  :conference
      t.string      :name
      t.datetime    :deleted_at
      t.timestamps
    end
  end
end
