# frozen_string_literal: true

class ResourceOfficer
  attr_reader :params, :current_user

  def initialize(params, current_user)
    @params       = params
    @current_user = current_user
  end

  def perform
    resource_page.title = params[:title]
    resource_page.save

    page_content = resource_page.page_content || build_page_content(resource_page)

    resource_detail = page_content.resource_detail || build_resource_detail(page_content)
    if params[:navigation_id].present?
    end
    resource_detail.navigation_id = params[:navigation_id]
    resource_detail.image         = params[:image] if params[:image].present?
    resource_detail.content       = params[:content]
    resource_detail.tag_list      = params[:tag_list]
    resource_detail.save!

    # manage files
    params[:files] = [] if params[:files].nil?
    params[:files].each do |file_param|
      page_file = PageFile.new(page_id: resource_page.id)
      page_file.save

      resource_file = ResourceFile.new(page_component_id: page_file.id)
      resource_file.file = file_param
      resource_file.save
    end
  end

  def resource_page
    @resource_page ||= ResourcePage.find_by(id: params[:id]) || build_page
  end

  def slug
    random = SecureRandom.hex(3)
    "#{params[:title].to_s.parameterize}-#{random}"
  end

  def build_page
    ResourcePage.create(
      user: current_user,
      slug: slug
    )
  end

  def build_page_content(page)
    PageContent.create(
      page_id: page.id
    )
  end

  def build_resource_detail(page_content)
    ResourceDetail.create(
      page_component_id: page_content.id
    )
  end
end
