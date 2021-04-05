# == Schema Information
#
# Table name: page_banner_details
#
#  id                :bigint           not null, primary key
#  page_component_id :bigint
#  image             :string
#  label             :string
#  sublabel          :string
#  deleted_at        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  url               :string
#
class PageBannerDetail < ApplicationRecord
  TRANSLATION_FIELDS = %i[label sublabel].freeze
  translate TRANSLATION_FIELDS

  mount_uploader :image, ImageUploader

  belongs_to :page_component
end
