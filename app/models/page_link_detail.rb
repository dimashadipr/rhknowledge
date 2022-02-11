# == Schema Information
#
# Table name: page_link_details
#
#  id                :bigint           not null, primary key
#  page_component_id :bigint
#  page_id           :bigint
#  image             :string
#  title             :string
#  description       :string
#  deleted_at        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class PageLinkDetail < ApplicationRecord
  TRANSLATION_FIELDS = %i[title description].freeze
  translate TRANSLATION_FIELDS

  mount_uploader :image, ImageUploader

  belongs_to :page_component
  belongs_to :page
end
