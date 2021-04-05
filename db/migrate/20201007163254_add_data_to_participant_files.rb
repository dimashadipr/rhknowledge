class AddDataToParticipantFiles < ActiveRecord::Migration[6.0]
  def change
    add_column :participant_files, :data, :jsonb, default: {}
  end
end
