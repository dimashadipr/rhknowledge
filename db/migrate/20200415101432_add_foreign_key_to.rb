class AddForeignKeyTo < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :users, :roles
    add_foreign_key :page_components, :pages
  end
end
