class CreateNetworks < ActiveRecord::Migration[6.0]
  def change
    create_table :networks do |t|
      t.string      :logo
      t.string      :name
      t.string      :description
      t.datetime    :deleted_at
      t.timestamps
    end
  end
end
