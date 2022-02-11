class AddStatusToParticipantFile < ActiveRecord::Migration[6.0]
  def change
    add_column :participant_files, :status, :string
  end
end
