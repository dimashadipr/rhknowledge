# == Schema Information
#
# Table name: conference_file_reviews
#
#  id            :bigint           not null, primary key
#  conference_id :bigint
#  category      :string
#  code          :string
#  description   :string
#  option        :string
#  data          :jsonb
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :conference_file_review do
    
  end
end
