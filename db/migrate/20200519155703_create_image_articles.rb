class CreateImageArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :image_articles do |t|
      t.string :file
      t.timestamps
    end
  end
end
