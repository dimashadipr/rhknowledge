class CreateMailerFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :mailer_files do |t|
      t.references  :mailer, index: true, foreign_key: true
      t.string      :file
      t.datetime    :deleted_at
      t.timestamps
    end
  end
end
