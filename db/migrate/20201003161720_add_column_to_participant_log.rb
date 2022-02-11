class AddColumnToParticipantLog < ActiveRecord::Migration[6.0]
  def change
    add_column :participant_logs, :resource_type, :string
    add_column :participant_logs, :resource_id, :integer
    add_reference :participant_logs, :user, index: true, foreign_key: true, default: nil
    add_column :participant_logs, :public, :integer, default: 0
  end
end
