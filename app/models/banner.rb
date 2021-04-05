# frozen_string_literal: true

# == Schema Information
#
# Table name: banners
#
#  id         :bigint           not null, primary key
#  image      :string
#  label      :string
#  sublabel   :string
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Banner < ApplicationRecord
  acts_as_paranoid

  mount_uploader :image, ImageUploader

  TRANSLATION_FIELDS = %i[label sublabel].freeze
  translate TRANSLATION_FIELDS

  def self.banner_options
    all.collect do |banner|
      [
        banner.label,
        banner.id,
        data: {
          image: banner.image&.preview&.url,
          label: banner.label,
          sublabel: banner.sublabel
        }
      ]
    end
  end
end
