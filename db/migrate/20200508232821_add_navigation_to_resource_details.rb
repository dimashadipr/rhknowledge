class AddNavigationToResourceDetails < ActiveRecord::Migration[6.0]
  def change
    add_reference :resource_details, :navigation, foreign_key: true
  end
end
