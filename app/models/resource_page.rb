# frozen_string_literal: true

# == Schema Information
#
# Table name: pages
#
#  id          :bigint           not null, primary key
#  user_id     :bigint
#  parent_id   :integer
#  type        :string
#  title       :string
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deleted_at  :datetime
#  data        :jsonb
#  description :string
#
class ResourcePage < Page
  has_one :page_content, class_name: 'PageContent', foreign_key: 'page_id', dependent: :destroy

  has_many :page_files, class_name: 'PageFile', foreign_key: 'page_id', dependent: :destroy

  scope :by_navigation_ids, lambda { |navigation_ids|
    return where nil if navigation_ids.blank?

    eager_load(page_content: [:resource_detail])
      .where('resource_details.navigation_id in (?)', navigation_ids)
  }

  scope :by_query, lambda { |query|
    return where nil if query.blank?

    query.downcase!

    where('lower(title) LIKE :query OR lower(slug) LIKE :query', query: "%#{query}%")
  }

  scope :by_date, lambda { |date|
    return where nil if date.blank?

    where(created_at: date)
  }

  def self.search(params = {})
    by_navigation_ids(params[:navigation_ids])
      .by_query(params[:query])
      .by_date(params[:date])
  end

  def image
    if page_content&.resource_detail&.image.blank?
      page_content&.resource_detail&.source&.image_header
    else
      page_content&.resource_detail&.image
    end
  end

  def content
    page_content&.resource_detail.try(:tr, :content)
  end

  def category
    page_content&.resource_detail&.navigation
  end

  def categories
    array = page_content&.resource_detail&.navigation&.titles || []
    array.map { |e| e[:title] }
  end

  def short_category
    categories.last(2).join(', ')
  end

  def tag_list
    page_content&.resource_detail&.tag_list || []
  end
end
