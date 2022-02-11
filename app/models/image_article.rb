# == Schema Information
#
# Table name: image_articles
#
#  id         :bigint           not null, primary key
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ImageArticle < ApplicationRecord
  mount_uploader :file, ImageUploader
end
