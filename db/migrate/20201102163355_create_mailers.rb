# frozen_string_literal: true

class CreateMailers < ActiveRecord::Migration[6.0]
  def change
    create_table :mailers do |t|
      t.references  :user, index: true, foreign_key: true
      t.string      :status
      t.string      :subject
      t.string      :slug
      t.text        :content
      t.datetime    :deleted_at
      t.timestamps
    end
  end
end
