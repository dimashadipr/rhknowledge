# == Schema Information
#
# Table name: mailer_files
#
#  id         :bigint           not null, primary key
#  mailer_id  :bigint
#  file       :string
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :mailer_file do
    
  end
end
