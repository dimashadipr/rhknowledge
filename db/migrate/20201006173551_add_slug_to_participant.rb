class AddSlugToParticipant < ActiveRecord::Migration[6.0]
  def change
    add_column :participants, :slug, :string, default: nil
  end
end
