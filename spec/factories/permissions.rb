# == Schema Information
#
# Table name: permissions
#
#  id         :bigint           not null, primary key
#  name       :string
#  action     :string
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :permission do
    
  end
end
