# == Schema Information
#
# Table name: networks
#
#  id          :bigint           not null, primary key
#  logo        :string
#  name        :string
#  description :string
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  url         :string
#
class Network < ApplicationRecord
  acts_as_paranoid

  mount_uploader :logo, ImageUploader

  TRANSLATION_FIELDS = %i[description].freeze
  translate TRANSLATION_FIELDS

  def self.network_options
    all.collect do |network|
      [
        network.name,
        network.id,
        data: {
          logo: network.logo&.preview&.url,
          name: network.name,
          description: network.description
        }
      ]
    end
  end
end
