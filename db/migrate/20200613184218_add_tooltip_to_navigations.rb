class AddTooltipToNavigations < ActiveRecord::Migration[6.0]
  def change
    add_column :navigations, :tooltip, :string, default: nil
  end
end
