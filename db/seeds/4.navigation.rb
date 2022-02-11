# frozen_string_literal: true

def insert_nav(list_params, parent = nil)
  code = list_params[:code]
  code = "#{parent.code}_#{list_params[:code]}" if list_params[:level] == 3
  navigation = Navigation.find_or_initialize_by(code: code)

  navigation.navigation_id = parent.id if parent.present?
  navigation.position = list_params[:position]
  navigation.title    = list_params[:title_id]
  navigation.level    = list_params[:level]
  navigation.editable = list_params[:editable]
  navigation.save

  # save en translation
  trans = Translation.find_or_initialize_by(
    lang: 'en',
    resource_type: 'Navigation',
    resource_id: navigation.id,
    column: 'title'
  )
  trans.content = list_params[:title_en]
  trans.save

  if list_params[:children].present?
    list_params[:children].each do |list_children|
      insert_nav(list_children, navigation)
    end
  end

  puts "Saved #{navigation.id} - #{navigation.title}"
end

list = [
  {
    code: 'about',
    title_en: 'About',
    title_id: 'Tentang',
    position: 1,
    level: 1,
    editable: true
  },
  {
    code: 'reference',
    title_en: 'Important Reference',
    title_id: 'Referensi Penting',
    position: 2,
    level: 1,
    editable: true,
    children: [
      {
        code: 'family_planning',
        title_en: 'Family Planning',
        title_id: 'Keluarga Berencana',
        position: 1,
        level: 2,
        editable: true,
        children: [
          {
            code: 'journal_articles',
            title_en: 'Journal Article',
            title_id: 'Artikel Jurnal',
            position: 1,
            level: 3,
            editable: true
          },
          {
            code: 'conference_abstract',
            title_en: 'Conference Abstract and Presentation',
            title_id: 'Abstrak Konferensi dan Paparan',
            position: 2,
            level: 3,
            editable: true
          },
          {
            code: 'legal_and_regulatory',
            title_en: 'Legal and Legulatory Documents',
            title_id: 'Dokumen Hukum dan Peraturan',
            position: 3,
            level: 3,
            editable: true
          },
          {
            code: 'other_document',
            title_en: 'Other Document',
            title_id: 'Dokumen Lainnya',
            position: 4,
            level: 3,
            editable: true
          }
        ]
      },
      {
        code: 'maternal_and_neonathal_health',
        title_en: 'Maternal and Neonatal Health',
        title_id: 'Kesehatan Ibu dan Neonatal',
        position: 2,
        level: 2,
        editable: true,
        children: [
          {
            code: 'journal_articles',
            title_en: 'Journal Article',
            title_id: 'Artikel Jurnal',
            position: 1,
            level: 3,
            editable: true
          },
          {
            code: 'conference_abstract',
            title_en: 'Conference Abstract and Presentation',
            title_id: 'Abstrak Konferensi dan Paparan',
            position: 2,
            level: 3,
            editable: true
          },
          {
            code: 'legal_and_regulatory',
            title_en: 'Legal and Legulatory Documents',
            title_id: 'Dokumen Hukum dan Peraturan',
            position: 3,
            level: 3,
            editable: true
          },
          {
            code: 'other_document',
            title_en: 'Other Document',
            title_id: 'Dokumen Lainnya',
            position: 4,
            level: 3,
            editable: true
          }
        ]
      },
      {
        code: 'child_health',
        title_en: 'Child Health',
        title_id: 'Kesehatan Anak',
        position: 3,
        level: 2,
        editable: true,
        children: [
          {
            code: 'journal_articles',
            title_en: 'Journal Article',
            title_id: 'Artikel Jurnal',
            position: 1,
            level: 3,
            editable: true
          },
          {
            code: 'conference_abstract',
            title_en: 'Conference Abstract and Presentation',
            title_id: 'Abstrak Konferensi dan Paparan',
            position: 2,
            level: 3,
            editable: true
          },
          {
            code: 'legal_and_regulatory',
            title_en: 'Legal and Legulatory Documents',
            title_id: 'Dokumen Hukum dan Peraturan',
            position: 3,
            level: 3,
            editable: true
          },
          {
            code: 'other_document',
            title_en: 'Other Document',
            title_id: 'Dokumen Lainnya',
            position: 4,
            level: 3,
            editable: true
          }
        ]
      },
      {
        code: 'adolescent_reproductive_health',
        title_en: 'Adolescent Reproductive Health',
        title_id: 'Kesehatan Reproduksi Remaja',
        position: 4,
        level: 2,
        editable: true,
        children: [
          {
            code: 'journal_articles',
            title_en: 'Journal Article',
            title_id: 'Artikel Jurnal',
            position: 1,
            level: 3,
            editable: true
          },
          {
            code: 'conference_abstract',
            title_en: 'Conference Abstract and Presentation',
            title_id: 'Abstrak Konferensi dan Paparan',
            position: 2,
            level: 3,
            editable: true
          },
          {
            code: 'legal_and_regulatory',
            title_en: 'Legal and Legulatory Documents',
            title_id: 'Dokumen Hukum dan Peraturan',
            position: 3,
            level: 3,
            editable: true
          },
          {
            code: 'other_document',
            title_en: 'Other Document',
            title_id: 'Dokumen Lainnya',
            position: 4,
            level: 3,
            editable: true
          }
        ]
      },
      {
        code: 'hiv_aids',
        title_en: 'HIV/AIDS and STIs',
        title_id: 'HIV/AIDS dan IMS Lainnya',
        position: 5,
        level: 2,
        editable: true,
        children: [
          {
            code: 'journal_articles',
            title_en: 'Journal Article',
            title_id: 'Artikel Jurnal',
            position: 1,
            level: 3,
            editable: true
          },
          {
            code: 'conference_abstract',
            title_en: 'Conference Abstract and Presentation',
            title_id: 'Abstrak Konferensi dan Paparan',
            position: 2,
            level: 3,
            editable: true
          },
          {
            code: 'legal_and_regulatory',
            title_en: 'Legal and Legulatory Documents',
            title_id: 'Dokumen Hukum dan Peraturan',
            position: 3,
            level: 3,
            editable: true
          },
          {
            code: 'other_document',
            title_en: 'Other Document',
            title_id: 'Dokumen Lainnya',
            position: 4,
            level: 3,
            editable: true
          }
        ]
      },
      {
        code: 'population_and_development',
        title_en: 'Population and Development',
        title_id: 'Kependudukan dan Pengembangan',
        position: 6,
        level: 2,
        editable: true,
        children: [
          {
            code: 'journal_articles',
            title_en: 'Journal Article',
            title_id: 'Artikel Jurnal',
            position: 1,
            level: 3,
            editable: true
          },
          {
            code: 'conference_abstract',
            title_en: 'Conference Abstract and Presentation',
            title_id: 'Abstrak Konferensi dan Paparan',
            position: 2,
            level: 3,
            editable: true
          },
          {
            code: 'legal_and_regulatory',
            title_en: 'Legal and Legulatory Documents',
            title_id: 'Dokumen Hukum dan Peraturan',
            position: 3,
            level: 3,
            editable: true
          },
          {
            code: 'other_document',
            title_en: 'Other Document',
            title_id: 'Dokumen Lainnya',
            position: 4,
            level: 3,
            editable: true
          }
        ]
      },
      {
        code: 'reproductive_health_financing',
        title_en: 'Reproductive Health Financing',
        title_id: 'Pembiayaan Kesehatan Reproduksi',
        position: 7,
        level: 2,
        editable: true,
        children: [
          {
            code: 'journal_articles',
            title_en: 'Journal Article',
            title_id: 'Artikel Jurnal',
            position: 1,
            level: 3,
            editable: true
          },
          {
            code: 'conference_abstract',
            title_en: 'Conference Abstract and Presentation',
            title_id: 'Abstrak Konferensi dan Paparan',
            position: 2,
            level: 3,
            editable: true
          },
          {
            code: 'legal_and_regulatory',
            title_en: 'Legal and Legulatory Documents',
            title_id: 'Dokumen Hukum dan Peraturan',
            position: 3,
            level: 3,
            editable: true
          },
          {
            code: 'other_document',
            title_en: 'Other Document',
            title_id: 'Dokumen Lainnya',
            position: 4,
            level: 3,
            editable: true
          }
        ]
      },
      {
        code: 'official_documents',
        title_en: 'Official Documents',
        title_id: 'Dokumen Resmi',
        position: 8,
        level: 2,
        editable: true,
        children: [
          {
            code: 'bkkbn',
            title_en: 'BKKBN',
            title_id: 'BKKBN',
            position: 1,
            level: 3,
            editable: true
          },
          {
            code: 'ministry_of_health',
            title_en: 'Ministry Of Health',
            title_id: 'Kementrian Kesehatan',
            position: 2,
            level: 3,
            editable: true
          },
          {
            code: 'bappenas',
            title_en: 'Bappenas',
            title_id: 'Bappenas',
            position: 3,
            level: 3,
            editable: true
          },
          {
            code: 'unfpa',
            title_en: 'UNFPA',
            title_id: 'UNFPA',
            position: 4,
            level: 3,
            editable: true
          },
          {
            code: 'unicef',
            title_en: 'UNICEF',
            title_id: 'UNICEF',
            position: 5,
            level: 3,
            editable: true
          }
        ]
      }
    ]
  },
  {
    code: 'research',
    title_en: 'Original Research',
    title_id: 'Penelitian',
    position: 3,
    level: 1,
    editable: true,
    children: [
      {
        code: 'original_article',
        title_en: 'Original Article',
        title_id: 'Artikel Asli',
        position: 1,
        level: 2,
        editable: true
      },
      {
        code: 'working_paper',
        title_en: 'Working Paper',
        title_id: 'Makalah Kerja',
        position: 2,
        level: 2,
        editable: true
      }
    ]
  },
  {
    code: 'capacity_building',
    title_en: 'Capacity Building',
    title_id: 'Pengembangan Kapasitas',
    position: 4,
    level: 1,
    editable: true
  },
  {
    code: 'upcoming_events',
    title_en: 'Upcoming Events and Key Dates',
    title_id: 'Tanggal Penting',
    position: 5,
    level: 1,
    editable: false
  },
  {
    code: 'networks_and_partners',
    title_en: 'Networks and Partners',
    title_id: 'Jejaring dan Rekan Kerja',
    position: 6,
    level: 1,
    editable: false
  },
  {
    code: 'trending_topic',
    title_en: 'Trending Topic',
    title_id: 'Topik Terkini',
    position: 7,
    level: 1,
    editable: false
  },
  {
    code: 'contacts',
    title_en: 'Contacts',
    title_id: 'Kontak',
    position: 8,
    level: 1,
    editable: false
  }
]

list.each do |list_nav|
  insert_nav(list_nav, nil)
end
