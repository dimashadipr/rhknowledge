# frozen_string_literal: true

puts 'Fix Category'

participants = Participant.where(conference_participant_id: nil)
mapping = {
  'Umum': 1,
  'Peserta Abstrak Oral': 2,
  'Peserta Seminar dan Mukernas': 1,
  'Peserta Abstrak Poster': 3
}
participants.each do |participant|
  category = participant.participant

  conference_participant_id = mapping[category.to_sym]
  participant.conference_participant_id = conference_participant_id
  participant.save
end

mapping = {
  'Inovasi Media dan Komunikasi perubahan perilaku masyarakat': 7,
  'Pemberdayaan masyarakat menanggulangi epidemi penyakit': 13,
  'Strategi peningkatan akses dan kualitas layanan': 2,
  'Penelitian lainnya terkait kesehatan masyarakat (epidemiologi, AKK, biostatistik, K3, KL, gizi, dan PKIP)': 17,
  'Pemberdayaan masyarakat mengendalikan mutu layanan dasar Kesehatan': 6,
  'Pemberdayaan masyarakat dalam menanggulangi silent epidemic (IMS dan HIV-AIDS)': 13,
  'Inovasi intervensi perbaikan gizi dan kesehatan remaja, ibu hamil, bayi dan anak': 5,
  'Inovasi program pendidikan kesehatan reproduksi remaja': 8,
  'Kendali mutu pelaksanaan program kesehatan reproduksi': 11,
  'Strategi pelaksanaan program KB berbasis Hak dalam adaptasi Kebiasaan Baru': 15,
  'Inovasi intervensi perbaikan status gizi dan kesehatan remaja, ibu hamil, bayi dan anak dalam era pandemi COVID-19': 5,
  'Inovasi pencegahan dan pengendalian IMS dan HIV': 9,
  'Peran akademisi dan praktisi kesehatan masyarakat dalam layanan kesehatan reproduksi': 16,
  'Inovasi pencegahan kekerasan berbasis gender dalam masa Pandemi': 14,
  'Monitoring, evaluasi, dan sistem informasi terintegrasi': 12,
  'Teknologi tepat guna pengolahan limbah medis dan APD': 3,
  'Model layanan kesehatan reproduksi di tempat kerja': 4,
  'Inovasi program pendidikan kesehatan reproduksi remaja yang komprehensif yang tepat guna': 8,
  'Integrasi, monitoring dan evaluasi, serta pemanfaatan sistem informasi kesehatan dalam pelayanan kesehatan masyarakat': 12,
  'Strategi pelaksanaan Program KB Hak Asasi dalam Adaptasi Kebiasaan Baru COVID-19': 15,
  'Upaya perbaikan sanitasi lingkungan untuk menurunkan stunting': 10
}

participants = Participant.where(conference_topic_id: nil)

participants.each do |participant|
  topic = participant.topic
  next if topic.blank?

  next if mapping[topic.to_sym].blank?

  participant.conference_topic_id = mapping[topic.to_sym]
  participant.save
end
