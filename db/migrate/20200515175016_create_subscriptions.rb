class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.string      :first_name
      t.string      :last_name
      t.string      :email
      t.string      :institution
      t.boolean     :active, default: true
      t.datetime    :deleted_at
      t.timestamps
    end
  end
end
