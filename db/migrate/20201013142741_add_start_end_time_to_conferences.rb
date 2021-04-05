class AddStartEndTimeToConferences < ActiveRecord::Migration[6.0]
  def change
    add_column :conferences, :start_time, :datetime, default: nil
    add_column :conferences, :end_time, :datetime, default: nil
  end
end
