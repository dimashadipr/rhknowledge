class CreateConferenceParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :conference_participants do |t|
      t.references  :conference
      t.string      :category
      t.datetime    :start_time
      t.datetime    :end_time
      t.datetime    :deleted_at
      t.timestamps
    end
  end
end
