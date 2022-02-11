class CreateSources < ActiveRecord::Migration[6.0]
  def change
    create_table :sources do |t|
      t.string   :name
      t.string   :code
      t.string   :image_header
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
