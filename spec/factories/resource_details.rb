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
FactoryBot.define do
  factory :resource_detail do
    
  end
end
