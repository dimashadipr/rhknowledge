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
FactoryBot.define do
  factory :network do
    
  end
end
