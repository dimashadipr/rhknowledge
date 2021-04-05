class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :type
      t.string :code
      t.string :name

      t.datetime :deleted_at
      t.timestamps
    end
    add_index :roles, :type
  end
end
