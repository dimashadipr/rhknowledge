# frozen_string_literal: true

# == Schema Information
#
# Table name: page_components
#
#  id             :bigint           not null, primary key
#  page_id        :bigint
#  type           :string
#  position       :integer
#  reference_type :string
#  reference_id   :integer
#  deleted_at     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class PageBanner < PageComponent
  acts_as_paranoid

  has_one :banner_detail, class_name: 'PageBannerDetail', foreign_key: :page_component_id, dependent: :destroy

end
