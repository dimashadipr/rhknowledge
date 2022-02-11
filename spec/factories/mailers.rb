# == Schema Information
#
# Table name: mailers
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  status     :string
#  subject    :string
#  slug       :string
#  content    :text
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :mailer do
    
  end
end
