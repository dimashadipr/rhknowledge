class AddDeletedAtToConferences < ActiveRecord::Migration[6.0]
  def change
    add_column :conferences, :created_at, :datetime, null: false
    add_column :conferences, :updated_at, :datetime, null: false
    add_column :conferences, :deleted_at, :datetime, default: nil
  end
end
