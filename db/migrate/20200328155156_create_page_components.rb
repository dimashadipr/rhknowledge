class CreatePageComponents < ActiveRecord::Migration[6.0]
  def change
    create_table :page_components do |t|
      t.references  :page
      t.string      :type
      t.integer     :position
      t.string      :reference_type
      t.integer     :reference_id
      t.datetime    :deleted_at
      t.timestamps
    end
  end
end
