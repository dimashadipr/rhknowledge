class AddDataToConferenceParticipants < ActiveRecord::Migration[6.0]
  def change
    add_column :conference_participants, :abstract_needed, :boolean, default: false
    add_column :conference_participants, :data, :jsonb, default: {}
  end
end
