# frozen_string_literal: true

class CreateRoleAbilities < ActiveRecord::Migration[6.0]
  def change
    create_table :role_abilities do |t|
      t.references :role, foreign_key: true
      t.references :permission, foreign_key: true
      t.datetime   :deleted_at
      t.timestamps
    end
  end
end
