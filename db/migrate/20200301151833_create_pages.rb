class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.references  :user
      t.integer     :parent_id
      t.string      :type
      t.string      :title
      t.string      :slug

      t.timestamps
    end
    add_index :pages, :slug, unique: true

  end
end
