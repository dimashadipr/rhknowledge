# frozen_string_literal: true

puts 'Send email to mukernas and seminar participant'

participants = Participant.all

participants.each do |participant|
  next if participant.latest_abstract_file.present?

  ParticipantMailer.with(participant: participant).seminar_registration_mailer.deliver_now

  puts "Send Email for #{participant.id} - #{participant.full_name}"
end
