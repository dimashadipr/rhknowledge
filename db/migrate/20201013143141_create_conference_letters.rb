class CreateConferenceLetters < ActiveRecord::Migration[6.0]
  def change
    create_table :conference_letters do |t|
      t.references  :conference
      t.string      :name
      t.string      :title
      t.string      :message
      t.string      :image
      t.integer     :position
      t.datetime    :deleted_at
      t.timestamps
    end
  end
end
