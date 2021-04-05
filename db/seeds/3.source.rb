# frozen_string_literal: true

sources = [
  {
    code: 'article',
    name: 'Article'
  },
  {
    code: 'journal',
    name: 'Journal'
  },
  {
    code: 'report',
    name: 'Report'
  }
]

sources.each do |source|
  source_data      = Source.find_or_initialize_by code: source[:code]
  source_data.name = source[:name]
  source_data.save

  puts "Save Source #{source_data.id} #{source_data.name}"
end
