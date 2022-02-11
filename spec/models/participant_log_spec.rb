# == Schema Information
#
# Table name: participant_logs
#
#  id             :bigint           not null, primary key
#  participant_id :bigint
#  message        :string
#  params         :jsonb
#  data           :jsonb
#  deleted_at     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  resource_type  :string
#  resource_id    :integer
#  user_id        :bigint
#  public         :integer          default("0")
#
require 'rails_helper'

RSpec.describe ParticipantLog, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
