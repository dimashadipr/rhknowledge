# == Schema Information
#
# Table name: participants
#
#  id                        :bigint           not null, primary key
#  user_id                   :bigint
#  front_title               :string
#  back_title                :string
#  title                     :string
#  name                      :string
#  email                     :string
#  phone                     :string
#  institution               :string
#  institution_phone         :string
#  participant               :string
#  topic                     :string
#  abstract                  :string
#  deleted_at                :datetime
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  whatsapp                  :string
#  data                      :jsonb
#  slug                      :string
#  conference_id             :bigint
#  conference_participant_id :bigint
#  conference_topic_id       :bigint
#
require 'rails_helper'

RSpec.describe Participant, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
