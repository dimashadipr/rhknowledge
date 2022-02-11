# frozen_string_literal: true

Rails.logger.level = 0

puts 'Create Conference'

conference            = Conference.find_or_initialize_by(id: 1)
conference.name       = 'Konferensi Nasional Kesehatan Reproduksi: Peluncuran Knowledge Hub dan Forum Ilmiah Tahunan IAKMI VI'
conference.status     = :active
conference.start_time = '2020-09-15 00:00:00'
conference.end_time   = '2020-11-26 23:59:59'

conference.save!

conference_registration = ConferenceRegistration.find_or_initialize_by(conference_id: conference.id)

conference_registration.start_time = '2020-09-15 00:00:00'
conference_registration.end_time   = '2020-11-24 23:59:59'

conference_registration.save!

data_quick_links = [
  { id: 2, label: 'TOR', position: 1 },
  { id: 3, label: 'Guideline', position: 2 },
  { id: 4, label: 'FAQ', position: 3 }
]

data_quick_links.each do |data|
  conference_quick_link = ConferenceQuickLink.find_or_initialize_by(
    conference_id: conference.id,
    id: data[:id]
  )
  conference_quick_link.label      = data[:label]
  conference_quick_link.position   = data[:position]
  conference_quick_link.save
end

data_participants = [
  { id: 1, category: 'Peserta Seminar', start_time: '2020-10-24 00:00:00', end_time: '2020-11-25 08:30:00', abstract_needed: false },
  { id: 2, category: 'Peserta Abstrak Oral', start_time: '2020-10-24 00:00:00', end_time: '2020-10-25 23:59:59', abstract_needed: true },
  { id: 3, category: 'Peserta Abstrak Poster', start_time: '2020-10-24 00:00:00', end_time: '2020-10-25 23:59:59', abstract_needed: true }
]

data_participants.each do |data|
  conference_participant = ConferenceParticipant.find_or_initialize_by(
    conference_id: conference.id,
    id: data[:id]
  )

  conference_participant.category        = data[:category]
  conference_participant.start_time      = data[:start_time] if data[:start_time].present?
  conference_participant.end_time        = data[:end_time] if data[:end_time].present?
  conference_participant.abstract_needed = data[:abstract_needed]
  conference_participant.save!
end

data_topics = [
  'Inovasi skrining dan surveilans',
  'Strategi peningkatan akses dan kualitas layanan',
  'Teknologi tepat guna pengolahan limbah medis dan APD',
  'Model layanan kesehatan reproduksi di tempat kerja',
  'Inovasi intervensi perbaikan gizi dan kesehatan remaja, ibu hamil, bayi dan anak',
  'Pemberdayaan masyarakat mengendalikan mutu layanan dasar Kesehatan',
  'Inovasi Media dan Komunikasi perubahan perilaku masyarakat',
  'Inovasi program pendidikan kesehatan reproduksi remaja',
  'Inovasi pencegahan dan pengendalian IMS dan HIV',
  'Upaya peningkatan akses air bersih dan perbaikan sanitasi lingkungan',
  'Kendali mutu pelaksanaan program kesehatan reproduksi',
  'Monitoring, evaluasi, dan sistem informasi terintegrasi',
  'Pemberdayaan masyarakat menanggulangi epidemi penyakit',
  'Inovasi pencegahan kekerasan berbasis gender dalam masa Pandemi',
  'Strategi pelaksanaan program KB berbasis Hak dalam adaptasi Kebiasaan Baru',
  'Peran akademisi dan praktisi kesehatan masyarakat dalam layanan kesehatan reproduksi',
  'Penelitian lainnya terkait kesehatan masyarakat (epidemiologi, AKK, biostatistik, K3, KL, gizi, dan PKIP)'
]

data_topics.each_with_index do |name, index|
  id = index + 1

  conference_topic = ConferenceTopic.find_or_initialize_by(
    conference_id: conference.id,
    id: id
  )

  conference_topic.name = name
  conference_topic.save
end

data_letters = [
  {
    id: 1,
    name: 'Dr. Ir. Subandi Sardjoko, M.Sc',
    title: 'Deputi Bidang Pembangunan Manusia, Masyarakat dan Kebudayaan, Bappenas',
    message: 'Peningkatan kualitas kesehatan ibu dan anak, Keluarga Berencana (KB), dan kesehatan reproduksi, merupakan salah satu arah kebijakan RPJMN 2020-2024 dalam mewujudkan pembangunan manusia yang berkualitas dan berdaya saing. Konferensi Nasional Kesehatan Reproduksi merupakan salah satu sarana dalam upaya menjawab isu-isu strategis yang mengemuka di bidang kesehatan reproduksi berbasis bukti (evidence based) dengan alternatif solusi yang inovatif. Rumusan tersebut akan sangat bermanfaat untuk mendukung perencanaan yang berbasis bukti dan agar kebijakan yang dirumuskan lebih tepat sasaran.'
  },
  {
    id: 2,
    name: 'Anjali Sen',
    title: 'UNFPA Indonesia',
    message: 'UNFPA is committed to achieve universal access to reproductive health, promote reproductive rights, reduce maternal mortality and family planning unmet needs, and improve the lives of adolescents and young people. This conference will be a strategic place to share lessons learned as well as recognize achievements and commitments to reproductive health in Indonesia. It provides an opportunity for policy makers, researchers, reproductive health advocates, and youths to disseminate knowledge, shared the latest reproductive health researches and innovations. I encourage you to participate in this conference and be part of reproductive health champions and communities.'
  },
  {
    id: 3,
    name: 'Prof. Dr. dr. Sabarinah Prasetyo, M.Sc',
    title: 'Dekan Fakultas Kesehatan Masyarakat Universitas Indonesia, FKM UI',
    message: 'Puji dan syukur kita panjatkan ke Hadirat Allah SWT, bahwa FKMUI diberi kesempatan uuntuk menyelenggarakan konferensi nasional bertema “inovasi dan pemberdayaan masyarakat untuk penguatan layanan kesehatan reproduksi pada masa adaptasi kebiasaan baru COVID-19”. Tema ini sangat relevan untuk kita semua, agar tujuan kita menyehatkan masyarakat secara paripurna tercapai walaupun kita harus hidup dengan kondisi belum terkendalinya pandemic COVID-19 di Indonesia. Kami mengajak semua akademisi, peneliti dan praktisi untuk berpartisipasi dalam konferensi nasional tersebut dan bersama-sama dapat mencermati dan membahas hal terkait hasil penelitian yang inovatif yang dapat meningkatkan upaya pemberdayaan masyarakat dalam area kesehatan reproduksi sebagai bagian dari kesehatan masyarakat. Terima kasih, salam semangat dan sampai jumpa.'
  },
  {
    id: 4,
    name: 'Prof. dr. Budi Utomo, MPH, PhD',
    title: 'Knowledge Hub Kesehatan Reproduksi Indonesia, FKM UI',
    message: 'COVID-19 merubah cara layanan dan mereduksi layanan kesehatan reproduksi, termasuk keluarga berencana, kesehatan maternal dan anak, dan IMS dan HIV-AIDS. IAKMI bekerjasama dengan Knowledge Hub for Reproductive Health Indonesia FKMUI akan menyelenggarakan Konferensi Nasional Kesehatan Reproduksi. Kami mengundang praktisi, akademisi kesehatan dan mahasiwa untuk berpartisipasi dalam Konferensi ini, sebagai forum terbuka mendiskusikan pandangan dan pengalaman inovasi, pemberdayaan masyarakat, dan upaya penguatan sistem layanan kesehatan reproduksi di masa adaptasi kebiasaan baru COVID-19.'
  },
  {
    id: 5,
    name: 'Dr. Ede Surya Darmawan, SKM, MDM',
    title: 'Ketua IAKMI',
    message: 'Mari bergabung, kita berbagi pengetahuan, informasi dan hasil penelitian untuk mendukung INOVASI DAN PEMBERDAYAAN MASYARAKAT UNTUK PENGUATAN LAYANAN KESEHATAN REPRODUKSI PADA MASA ADAPTASI KEBIASAAN BARU COVID-19. Mari hadir bersama dalam Forum Ilmiah Tahunan (FIT) ke 6 IAKMI dan konferensi nasional Knowledge Hub FKMUI.'
  }
]

data_letters.each do |data|
  conference_participant = ConferenceLetter.find_or_initialize_by(conference_id: conference.id, id: data[:id])

  conference_participant.name         = data[:name]
  conference_participant.title        = data[:title]
  conference_participant.message      = data[:message]
  conference_participant.position     = data[:id] + 1
  conference_participant.save
end

data_speakers = [
  {
    name: 'dr. Hasto Wardoyo, Sp.OG(K)',
    title: 'Kepala Badan Kependudukan dan Keluarga Berencana Nasional',
    group: 'keynote_speakers'
  },
  {
    name: 'Bjorn Andersson',
    title: 'UNFPA Asia and Pacific Regional Director',
    group: 'keynote_speakers'
  },
  {
    name: 'Prof. Dr. dr. Sabarinah Prasetyo, M.Sc',
    title: 'Dekan Fakultas Kesehatan Masyarakat Universitas Indonesia',
    group: 'sambutan'
  },
  {
    name: 'Anjali Sen',
    title: 'UNFPA representative',
    group: 'sambutan'
  },
  {
    name: 'Dr. Ede Surya Darmawan, SKM, MDM',
    title: 'Ketua Umum Ikatan Ahli Kesehatan Masyarakat Indonesia (IAKMI)',
    group: 'sambutan'
  },
  {
    name: 'Woro Srihastuti Sulistyaningrum, ST, MIDS',
    title: 'Direktur KPAPO Kementerian PPN/BAPPENAS',
    group: 'plenary_1',
    position: 'moderator'
  },
  {
    name: 'Dr. Ir. Subandi Sardjoko, M.Sc',
    title: 'Deputi Bidang Pembangunan Manusia, Masyarakat, dan Kebudayaan Kementerian PPN/Bappenas',
    group: 'plenary_1'
  },
  {
    name: 'dr. Kirana Pritasari, MQIH',
    title: 'Direktur Jenderal Kesehatan Masyarakat Kementerian Kesehatan',
    group: 'plenary_1'
  },
  {
    name: 'Meiki Laka Lena',
    title: 'Pimpinan Komisi IX DPR RI',
    group: 'plenary_1'
  },
  {
    name: 'Dr. dr. Melania Hidayat, MPH',
    title: 'Assistant Representative UNFPA Indonesia',
    group: 'plenary_1'
  },
  {
    name: 'Riznawaty Imma Aryanty, SKM, M.Sc, Ph.D',
    title: 'Reproductive Health Programme Specialist UNFPA Indonesia',
    group: 'plenary_2',
    position: 'moderator'
  },
  {
    name: 'dr. Eni Gustina, MPH',
    title: 'Deputi KB dan Kesehatan Reproduksi BKKBN',
    group: 'plenary_2'
  },
  {
    name: 'dr. Irwan Heriyanto',
    title: 'Chief of Medical Officer Halodoc',
    group: 'plenary_2'
  },
  {
    name: 'Prof. dr. Budi Utomo, MPH, PhD',
    title: 'Knowledge Hub Fakultas Kesehatan Masyarakat Universitas Indonesia',
    group: 'plenary_2'
  },
  {
    name: 'Dr. Ede Surya Darmawan, SKM, MDM',
    title: 'Ketua Umum Ikatan Ahli Kesehatan Masyarakat Indonesia (IAKMI)',
    group: 'plenary_2'
  },
  {
    name: 'Prof. Walter Ricciardi',
    title: 'World Federation Public Health Association',
    group: 'guest_lecture'
  }
]

data_speakers.each_with_index do |data, index|
  id = index + 1
  conference_participant = ConferenceSpeaker.find_or_initialize_by(
    conference_id: conference.id,
    id: id
  )

  conference_participant.name                = data[:name]
  conference_participant.title               = data[:title]
  conference_participant.position            = id
  conference_participant.group               = data[:group]
  conference_participant.conference_position = data[:position]
  conference_participant.save
end

participants = Participant.all

participants.each do |participant|
  participant.conference_id = conference.id
  participant.save
end
