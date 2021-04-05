class AddDataToMailerRecipient < ActiveRecord::Migration[6.0]
  def change
    add_column :mailer_recipients, :data, :jsonb, default: {}
  end
end
