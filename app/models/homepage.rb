# frozen_string_literal: true

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
class Homepage < Page
  has_many :page_banners, class_name: 'PageBanner', foreign_key: 'page_id'
  has_many :page_links, class_name: 'PageLink', foreign_key: 'page_id'

  def instagram_url
    data['instagram_url']
  end
end
