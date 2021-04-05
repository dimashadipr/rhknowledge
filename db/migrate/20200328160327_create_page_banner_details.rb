class CreatePageBannerDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :page_banner_details do |t|
      t.references  :page_component
      t.string      :image
      t.string      :label
      t.string      :sublabel
      t.datetime    :deleted_at
      t.timestamps
    end
  end
end
