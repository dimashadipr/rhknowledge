class AddConferencePositionToConferencesSpeakers < ActiveRecord::Migration[6.0]
  def change
    add_column :conference_speakers, :group, :string, default: nil
    add_column :conference_speakers, :conference_position, :string, default: nil
  end
end
