class AddCreatedByToReviewer < ActiveRecord::Migration[6.0]
  def change
    add_column :participant_file_reviews, :created_by, :integer, default: nil
    add_column :participant_file_reviews, :score, :integer, default: nil
  end
end
