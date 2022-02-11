class CreateResourceDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :resource_details do |t|
      t.references :page_component, foreign_key: true
      t.references :source, foreign_key: true
      t.string     :image
      t.text       :content
      t.datetime   :deleted_at
      t.timestamps
    end
  end
end
