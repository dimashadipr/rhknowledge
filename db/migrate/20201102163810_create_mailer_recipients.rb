class CreateMailerRecipients < ActiveRecord::Migration[6.0]
  def change
    create_table :mailer_recipients do |t|
      t.references  :mailer, index: true, foreign_key: true
      t.string      :email
      t.string      :name
      t.string      :status
      t.datetime    :deleted_at
      t.timestamps
    end
  end
end
