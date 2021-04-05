class AddWhatsappToParticipant < ActiveRecord::Migration[6.0]
  def change
    add_column :participants, :whatsapp, :string, default: nil
  end
end
