class CreateResourceFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :resource_files do |t|
      t.references :page_component, foreign_key: true
      t.string     :file
      t.datetime   :deleted_at
      t.timestamps
    end
  end
end
