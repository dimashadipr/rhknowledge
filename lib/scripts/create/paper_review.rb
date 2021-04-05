conference = Conference.first
file_reviews = [
  {
    category: 'paper_review',
    code: 'c1pr1',
    description: '<p><strong>Judul</strong></p><ul style="list-style-type:circle"><li>Mencerminkan&nbsp;masalah yang dibahas</li><li>Memiliki&nbsp;daya&nbsp;tarik (provokatif)</li></ul>',
    option: 'number',
    data: {
      weight: 5,
      score_min: 1,
      score_max: 5,
      html: true
    }
  },
  {
    category: 'paper_review',
    code: 'c1pr2',
    description: '<p><strong>Abstrak</strong><strong>&nbsp;</strong></p><ul style="list-style-type:circle"><li>Menggambarkan&nbsp;secara&nbsp;ringkas&nbsp;isi&nbsp;tulisan (latar&nbsp;belakang, tujuan dan kesimpulan)</li><li>Kata kunci</li></ul>',
    option: 'number',
    data: {
      weight: 10,
      score_min: 1,
      score_max: 5,
      html: true
    }
  },
  {
    category: 'paper_review',
    code: 'c1pr3',
    description: '<p><strong>Pendahuluan</strong></p><ul><li>Memberikan&nbsp;acuan (konteks) permasalahan</li><li>Berisi&nbsp;hal-hal yang menarik (kontroversial, belum&nbsp;tuntas, perkembangan&nbsp;baru</li><li>Berisi&nbsp;rumusan&nbsp;singkat (hal-hal&nbsp;pokok yang akan&nbsp;dibahas)</li><li>15-20% panjang&nbsp;artikel</li><li>Tanpa sub judul</li><li>Tujuan</li></ul>',
    option: 'number',
    data: {
      weight: 15,
      score_min: 1,
      score_max: 5,
      html: true
    }
  },
  {
    category: 'paper_review',
    code: 'c1pr4',
    description: '<p><strong>Metode</strong></p><ul><li>Desain Studi</li><li>Populasi dan sampel/Informan/</li><li>Spesimen (studi&nbsp;laboratorium)</li><li>Lokasi dan waktu</li><li>Variabel yang dianalisis</li><li>Instrumen</li><li>Analisis data</li><li>Etik penelitian</li></ul>',
    option: 'number',
    data: {
      weight: 15,
      score_min: 1,
      score_max: 5,
      html: true
    }
  },
  {
    category: 'paper_review',
    code: 'c1pr5',
    description: '<p><strong>Hasil</strong></p><ul><li>Penyajian&nbsp;dalam&nbsp;bentuk&nbsp;diagram/tabel/gambar</li><li>Jelas dan sesuai&nbsp;dengan&nbsp;tujuan</li><li>Khusus&nbsp;studi&nbsp;kualitatif: hasil&nbsp;didukung oleh kutipan yang relevan</li></ul>',
    option: 'number',
    data: {
      weight: 15,
      score_min: 1,
      score_max: 5,
      html: true
    }
  },
  {
    category: 'paper_review',
    code: 'c1pr6',
    description: '<p><strong>Pembahasan</strong></p><ul><li>Berisi&nbsp;kupasan</li><li>Bersifat&nbsp;analitik, argumentatif, logis, kritis</li><li>Citasi yang relevan dan berasal&nbsp;dari&nbsp;artikel&nbsp;asli&nbsp;</li></ul>',
    option: 'number',
    data: {
      weight: 25,
      score_min: 1,
      score_max: 5,
      html: true
    }
  },
  {
    category: 'paper_review',
    code: 'c1pr7',
    description: '<p><strong>Kesimpulan</strong></p><p>ada&nbsp;benang&nbsp;merah&nbsp;antara&nbsp;judul, permasalahan,tujuan dan hasil.</p>',
    option: 'number',
    data: {
      weight: 10,
      score_min: 1,
      score_max: 5,
      html: true
    }
  },
  {
    category: 'paper_review',
    code: 'c1pr8',
    description: '<p><strong>Kepustakaan</strong></p><ul><li>Konsisten&nbsp;(<em>Vancouver Style</em>)</li><li>Mengikuti&nbsp;aturan&nbsp;jurnal</li><li>Jumlah&nbsp;kepustakaan minimal 15 referensi&nbsp;(60-80% referensi&nbsp;berasal&nbsp;artikel&nbsp;asli&nbsp;dari&nbsp;jurnal&nbsp;artikel&nbsp;dalam 10 tahun&nbsp;terakhir)</li></ul>',
    option: 'number',
    data: {
      weight: 5,
      score_min: 1,
      score_max: 5,
      html: true
    }
  },
  {
    category: 'paper_review',
    code: 'c1pr9',
    description: 'Naskah dapat dimuat tanpa perubahan',
    option: 'checklist',
    data: {}
  },
  {
    category: 'paper_review',
    code: 'c1pr10',
    description: 'Naskah dapat dimuat dengan perbaikan yang telah dikerjakan oleh Penyunting Ahli (Mohon dituliskan garis besar revisi pada naskah, dan naskah yg telah direvisi dikembalikkan kepada kami).',
    option: 'checklist',
    data: {}
  },
  {
    category: 'paper_review',
    code: 'c1pr11',
    description: 'Naskah dapat dimuat dengan perbaikan format dan bahasa yang perlu dikerjakan oleh Penyunting Pelaksana (mohon dituliskan jika ada yang bersifat khusus)',
    option: 'checklist',
    data: {}
  },
  {
    category: 'paper_review',
    code: 'c1pr12',
    description: 'Penulis naskah perlu melakukan perbaikan terhadap hal-hal berikut (lihat catatan atau komentar di naskah)',
    option: 'checklist',
    data: {}
  },
  {
    category: 'paper_review',
    code: 'c1pr13',
    description: 'Naskah tidak dapat dimuat',
    option: 'checklist',
    data: {}
  }
]

file_reviews.each do |fr|
  conference_file_review = ConferenceFileReview.find_or_initialize_by code: fr[:code]

  conference_file_review.conference = conference
  conference_file_review.category = fr[:category]
  conference_file_review.description = fr[:description]
  conference_file_review.option = fr[:option]
  conference_file_review.data = fr[:data]
  conference_file_review.save

  puts "Saved #{conference_file_review}"
end
