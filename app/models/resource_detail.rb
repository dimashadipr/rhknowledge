# frozen_string_literal: true

# == Schema Information
#
# Table name: resource_details
#
#  id                :bigint           not null, primary key
#  page_component_id :bigint
#  source_id         :bigint
#  image             :string
#  content           :text
#  deleted_at        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  navigation_id     :bigint
#
class ResourceDetail < ApplicationRecord
  acts_as_paranoid

  acts_as_taggable_on :tags

  belongs_to :page_content, class_name: 'PageContent', foreign_key: 'page_component_id', touch: true
  belongs_to :navigation, optional: true
  
  mount_uploader :image, ImageUploader

  TRANSLATION_FIELDS = %i[content].freeze
  translate TRANSLATION_FIELDS
end
