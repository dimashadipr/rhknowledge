class AddDataToPage < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :data, :jsonb, default: {}
    add_column :pages, :description, :string, default: nil
  end
end
