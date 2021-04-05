class CreateParticipantLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :participant_logs do |t|
      t.references  :participant, foreign_key: true
      t.string      :message
      t.jsonb       :params
      t.jsonb       :data
      t.datetime    :deleted_at
      t.timestamps
    end
  end
end
