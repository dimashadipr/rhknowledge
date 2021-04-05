participant = Participant.last

ParticipantMailer.with(participant: participant).abstract_registration_mailer.deliver_now
