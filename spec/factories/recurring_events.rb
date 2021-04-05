# == Schema Information
#
# Table name: recurring_events
#
#  id           :bigint           not null, primary key
#  user_id      :bigint
#  category     :string
#  name         :string
#  day_number   :integer
#  day_date     :integer
#  month_number :integer
#  active_until :datetime
#  deleted_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  factory :recurring_event do
    
  end
end
