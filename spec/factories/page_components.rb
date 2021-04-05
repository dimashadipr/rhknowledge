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
FactoryBot.define do
  factory :page_component do
    
  end
end
