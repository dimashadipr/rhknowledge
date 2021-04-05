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
class ParticipantLog < ApplicationRecord
  acts_as_paranoid

  belongs_to :participant
  belongs_to :user, optional: true
  belongs_to :resource, polymorphic: true, optional: true
end
