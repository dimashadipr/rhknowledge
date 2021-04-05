# frozen_string_literal: true

# == Schema Information
#
# Table name: conferences
#
#  id         :bigint           not null, primary key
#  name       :string
#  status     :integer
#  start_time :datetime
#  end_time   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#
class Conference < ApplicationRecord
  acts_as_paranoid

  has_one  :conference_registration, dependent: :destroy
  has_one  :conference_banner, dependent: :destroy

  has_many :conference_letters, dependent: :destroy
  has_many :conference_speakers, dependent: :destroy
  has_many :conference_participants, dependent: :destroy
  has_many :conference_topics, dependent: :destroy
  has_many :conference_quick_links, dependent: :destroy

  has_many :conference_file_reviews
  has_many :paper_reviews, -> { where(category: 'paper_review') }, class_name: 'ConferenceFileReview'

  enum status: %i[inactive active]

  def participant_options
    conference_participants.map do |cp|
      name = cp.category
      [
        name,
        cp.id,
        disabled: cp.disabled?,
        data: { start_time: cp.start_time, end_time: cp.end_time,
                abstract_needed: cp.abstract_needed }
      ]
    end
  end

  def topic_options
    conference_topics.each_with_index.map do |ct, index|
      [
        "#{(index + 1)}. #{ct.name}",
        ct.id
      ]
    end
  end

  def active_registration?
    return false if status != 'active'

    conference_registration.active?
  end
end
