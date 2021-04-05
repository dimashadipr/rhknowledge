# frozen_string_literal: true

class HomepageOfficer
  attr_reader :params

  def initialize(homepage, params)
    @homepage = homepage
    @params   = params
  end

  def perform
    # manage page -> homepage
    manage_homepage

    # manage banner, banner detail
    manage_banner

    manage_links
  end

  def manage_homepage
    @homepage.title = params[:title]
    @homepage.description = params[:description]
    @homepage.data['instagram_url'] = params[:instagram_url]
    @homepage.save!
  end

  def manage_banner
    return if params[:page_banners].blank?

    params[:page_banners].each do |index, banner_param|
      page_banner = @homepage.page_banners.find_by id: banner_param[:id]
      if banner_param[:deleted] == 'true'
        page_banner.destroy if page_banner.present?
        next
      end

      page_banner = @homepage.page_banners.new if page_banner.blank?

      page_banner.position = index.to_i + 1
      page_banner.save!

      banner_detail = PageBannerDetail.find_or_initialize_by(page_component_id: page_banner.id)
      banner_detail.image = banner_param[:image] if banner_param[:image].present?
      banner_detail.url   = banner_param[:url]
      banner_detail.save!
    end
  end

  def manage_links
    return if params[:page_links].blank?

    params[:page_links].each do |index, link_param|
      page_link = @homepage.page_links.find_by id: link_param[:id]
      if link_param[:deleted] == 'true'
        page_link.destroy if page_link.present?
        next
      end

      page_link = @homepage.page_links.new if page_link.blank?

      page_link.position = index.to_i + 1
      page_link.save!

      link_detail = PageLinkDetail.find_or_initialize_by(page_component_id: page_link.id)
      link_detail.page_id = link_param[:page_id]
      link_detail.image = link_param[:image] if link_param[:image].present?
      link_detail.save!
    end
  end
end
