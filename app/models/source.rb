# frozen_string_literal: true

# == Schema Information
#
# Table name: sources
#
#  id           :bigint           not null, primary key
#  name         :string
#  code         :string
#  image_header :string
#  deleted_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Source < ApplicationRecord
  acts_as_paranoid

  mount_uploader :image_header, ImageUploader

  has_many :resource_details

  def self.source_options
    all.collect do |source|
      [
        source.name,
        source.id,
        data: {
          image_header: source.image_header&.preview&.url
        }
      ]
    end
  end
end
