# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string      :type
      t.references  :role
      t.string      :name
      t.string      :phone

      t.datetime :deleted_at
      t.timestamps
    end

    add_index :users, :type
  end
end
