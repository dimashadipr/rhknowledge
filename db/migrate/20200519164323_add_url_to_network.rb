class AddUrlToNetwork < ActiveRecord::Migration[6.0]
  def change
    add_column :networks, :url, :string
  end
end
