# == Schema Information
#
# Table name: role_abilities
#
#  id            :bigint           not null, primary key
#  role_id       :bigint
#  permission_id :bigint
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :role_ability do
    
  end
end
