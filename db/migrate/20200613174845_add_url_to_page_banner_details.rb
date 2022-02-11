class AddUrlToPageBannerDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :page_banner_details, :url, :string, default: nil
  end
end
