# frozen_string_literal: true

pages = [
  {
    slug: 'homepage',
    type: 'Homepage',
    title: 'Home Page'
  }
]

pages.each do |page|
  page_data       = Page.find_or_initialize_by slug: page[:slug]
  page_data.type  = page[:type]
  page_data.title = page[:title]
  page_data.user  = User.first
  page_data.save!

  puts "Save Page #{page_data.id} #{page_data.title}"
end
