# == Schema Information
#
# Table name: mailer_recipients
#
#  id         :bigint           not null, primary key
#  mailer_id  :bigint
#  email      :string
#  name       :string
#  status     :string
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  data       :jsonb
#
FactoryBot.define do
  factory :mailer_recipient do
    
  end
end
