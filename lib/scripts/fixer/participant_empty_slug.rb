participants = Participant.where(slug: nil)
participants.each do |participant|
  slug = SecureRandom.hex

  participant.slug = slug
  participant.save
end
