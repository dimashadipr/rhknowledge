class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.string    :name
      t.string    :action
      t.datetime  :deleted_at
      t.timestamps
    end
  end
end
