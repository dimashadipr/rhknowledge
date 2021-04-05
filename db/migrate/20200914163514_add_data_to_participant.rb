class AddDataToParticipant < ActiveRecord::Migration[6.0]
  def change
    add_column :participants, :data, :jsonb, default: {}
  end
end
