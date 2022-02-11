class AddConferenceIdToParticipants < ActiveRecord::Migration[6.0]
  def change
    add_reference :participants, :conference, index: true, foreign_key: true, default: nil
    add_reference :participants, :conference_participant, index: true, foreign_key: true, default: nil
    add_reference :participants, :conference_topic, index: true, foreign_key: true, default: nil
  end
end
