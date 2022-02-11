# == Schema Information
#
# Table name: resource_files
#
#  id                :bigint           not null, primary key
#  page_component_id :bigint
#  file              :string
#  deleted_at        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
FactoryBot.define do
  factory :resource_file do
    
  end
end
