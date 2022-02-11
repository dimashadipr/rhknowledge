# frozen_string_literal: true

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
class ConferenceFileReview < ApplicationRecord
  acts_as_paranoid

  belongs_to :conference

  def html?
    data['html']
  end

  def calculation?
    return true if option == 'number'

    false
  end

  def checklist?
    option == 'checklist'
  end

  def weight
    data['weight']
  end

  def score_calculation(score)
    return score unless calculation?

    return score if weight.blank?

    score * weight
  end
end
