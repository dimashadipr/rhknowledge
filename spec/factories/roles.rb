# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  type       :string
#  code       :string
#  name       :string
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :role do
    type { "" }
    code { "MyString" }
    name { "MyString" }
  end
end
