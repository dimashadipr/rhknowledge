# frozen_string_literal: true

class CreateNavigation < ActiveRecord::Migration[6.0]
  def change
    create_table :navigations do |t|
      t.integer     :navigation_id
      t.string      :code
      t.integer     :position
      t.string      :title
      t.references  :page, foreign_key: true, default: nil
      t.integer     :level
      t.boolean     :editable, default: true
      t.datetime    :deleted_at
      t.timestamps
    end
  end
end
