# frozen_string_literal: true

# == Schema Information
#
# Table name: conference_participants
#
#  id              :bigint           not null, primary key
#  conference_id   :bigint
#  category        :string
#  start_time      :datetime
#  end_time        :datetime
#  deleted_at      :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  abstract_needed :boolean          default("false")
#  data            :jsonb
#
class ConferenceParticipant < ApplicationRecord
  acts_as_paranoid

  scope :by_conference_id, lambda { |conference_id|
    return where nil if conference_id.blank?

    where(conference_id: conference_id)
  }

  def self.search(params = {})
    by_conference_id(params[:conference_id])
  end

  def disabled?
    now = DateTime.now
    return true if now < start_time || now > end_time

    false
  end
end
