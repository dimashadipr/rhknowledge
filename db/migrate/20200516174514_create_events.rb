# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.references :user, foreign_key: true
      t.string     :title
      t.string     :description
      t.string     :location
      t.datetime   :start_date
      t.datetime   :end_date
      t.datetime   :deleted_at
      t.timestamps
    end
  end
end
