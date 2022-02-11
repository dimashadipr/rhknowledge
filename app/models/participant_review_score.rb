# == Schema Information
#
# Table name: participant_review_scores
#
#  id                          :bigint           not null, primary key
#  participant_file_reviews_id :bigint
#  category                    :string
#  score                       :integer
#  deleted_at                  :datetime
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  conference_file_review_id   :bigint
#
class ParticipantReviewScore < ApplicationRecord
  acts_as_paranoid

  belongs_to :conference_file_review, optional: true
end
