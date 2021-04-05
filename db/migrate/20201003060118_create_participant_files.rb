class CreateParticipantFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :participant_files do |t|
      t.references :participant, foreign_key: true
      t.string     :type
      t.string     :file
      t.datetime   :deleted_at
      t.timestamps
    end
  end
end
