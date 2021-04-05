class CreatePageNetworkDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :page_network_details do |t|
      t.references  :page_component
      t.string      :logo
      t.string      :name
      t.string      :description
      t.datetime    :deleted_at
      t.timestamps
    end
  end
end
