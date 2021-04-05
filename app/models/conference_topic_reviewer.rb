# == Schema Information
#
# Table name: conference_topic_reviewers
#
#  id                  :bigint           not null, primary key
#  conference_topic_id :bigint
#  user_id             :bigint
#  deleted_at          :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class ConferenceTopicReviewer < ApplicationRecord
  acts_as_paranoid
end
