class CreateConferenceAssets < ActiveRecord::Migration[6.0]
  def change
    create_table :conference_assets do |t|
      t.references  :conference
      t.string      :type
      t.string      :image
      t.string      :file
      t.string      :label
      t.integer     :position
      t.datetime    :deleted_at
      t.timestamps
    end
  end
end
