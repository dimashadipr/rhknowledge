class CreateConferenceRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :conference_registrations do |t|
      t.references  :conference
      t.datetime    :start_time
      t.datetime    :end_time
      t.datetime    :deleted_at
      t.timestamps
    end
  end
end
