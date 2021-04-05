# == Schema Information
#
# Table name: pages
#
#  id          :bigint           not null, primary key
#  user_id     :bigint
#  parent_id   :integer
#  type        :string
#  title       :string
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted_at  :datetime
#  data        :jsonb
#  description :string
#
class Page < ApplicationRecord
  acts_as_taggable
  acts_as_paranoid

  TRANSLATION_FIELDS = %i[title description].freeze
  translate TRANSLATION_FIELDS

  belongs_to :user

  has_many :page_components
  has_many :page_banners, -> { order(:position) }, class_name: 'PageBanner'

  def self.link_options
    where.not(type: 'Homepage').collect do |banner|
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
