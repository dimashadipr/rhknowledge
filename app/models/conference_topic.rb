# == Schema Information
#
# Table name: conference_topics
#
#  id            :bigint           not null, primary key
#  conference_id :bigint
#  name          :string
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class ConferenceTopic < ApplicationRecord
  acts_as_paranoid

  scope :by_conference_id, lambda { |conference_id|
    return where nil if conference_id.blank?

    where(conference_id: conference_id)
  }

  def self.search(params = {})
    by_conference_id(params[:conference_id])
  end
end
