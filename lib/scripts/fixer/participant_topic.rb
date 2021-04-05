participants = Participant.all

participants.each do |participant|
  topic = participant.topic
  topic = topic.split('. ').reject.with_index { |_v, i| i == 0 }
  participant.topic = topic.join(' ')

  participant.save!
end
