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
FactoryBot.define do
  factory :banner do
    
  end
end
