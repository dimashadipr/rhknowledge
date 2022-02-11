class CreateTranslations < ActiveRecord::Migration[6.0]
  def change
    create_table :translations do |t|
      t.string   :lang
      t.string   :resource_type
      t.integer  :resource_id
      t.string   :column
      t.text     :content
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
