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
FactoryBot.define do
  factory :page_banner_detail do

  end
end
