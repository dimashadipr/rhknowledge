# == Schema Information
#
# Table name: conference_registrations
#
#  id            :bigint           not null, primary key
#  conference_id :bigint
#  start_time    :datetime
#  end_time      :datetime
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class ConferenceRegistration < ApplicationRecord
  acts_as_paranoid

  def active?
    now = DateTime.now
    return false if now < start_time || now > end_time

    true
  end
end
