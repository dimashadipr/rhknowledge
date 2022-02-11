# frozen_string_literal: true
Rails.logger.level = 0
date = DateTime.now.beginning_of_day - 3.days
participants = Participant.where('created_at >= ?', date)

participants.each do |participant|
  category_number = participant.data['category_number']

  next if category_number.blank? || category_number.to_i != 17

  puts participant.name

  abstract_file = participant.latest_abstract_file
  reviews = abstract_file.participant_file_reviews

  # update abstract
  abstract_file.status = 'submitted'
  abstract_file.save!
  # remove reviews

  reviews.each(&:destroy)
end

user = User.find_by email: 'rrmagnani@gmail.com'

# get rrmagnani review
reviews = ParticipantFileReview.where(user_id: user.id).where(created_by: nil)
reviews.each do |review|
  abstract_file = review.participant_file

  abstract_file.status = 'submitted'
  abstract_file.save!

  review.destroy
end

Rails.logger.level = 1
