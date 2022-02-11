class CreatePageLinkDetail < ActiveRecord::Migration[6.0]
  def change
    create_table :page_link_details do |t|
      t.references  :page_component, foreign_key: true
      t.references  :page, foreign_key: true
      t.string      :image
      t.string      :title
      t.string      :description
      t.datetime    :deleted_at
      t.timestamps
    end
  end
end
