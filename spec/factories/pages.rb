# == Schema Information
#
# Table name: pages
#
#  id          :bigint           not null, primary key
#  user_id     :bigint
#  parent_id   :integer
#  type        :string
#  title       :string
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted_at  :datetime
#  data        :jsonb
#  description :string
#
FactoryBot.define do
  factory :page do
    type { "" }
    title { "MyString" }
    slug { "MyString" }
    content { "MyText" }
  end
end
