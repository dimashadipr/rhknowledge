class CreateRecurringEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :recurring_events do |t|
      t.references  :user, foreign_key: true
      t.string      :category, comment: 'daily, weekly, monthly, yearly'
      t.string      :name
      t.integer     :day_number, comment: 'for weekly 0-6, 0: sunday '
      t.integer     :day_date, comment: 'for monthly, select day date'
      t.integer     :month_number, comment: 'for yearly, select month date number'
      t.datetime    :active_until
      t.datetime    :deleted_at
      t.timestamps
    end
  end
end
