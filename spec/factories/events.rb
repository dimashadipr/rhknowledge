# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  user_id     :bigint
#  title       :string
#  description :string
#  location    :string
#  start_date  :datetime
#  end_date    :datetime
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :event do
    
  end
end
