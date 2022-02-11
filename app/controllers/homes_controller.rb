# frozen_string_literal: true

class HomesController < WebController
  layout 'web'
  require 'oembed'

  def default_url_options
    { locale: locale }
  end

  def index
    OEmbed::Providers.register_all

    @homepage = Page.find_by slug: 'homepage'
    # @resource_pages = ResourcePage.order(updated_at: :desc).limit(6)
    @networks = Network.all
    @resource = nil
    if @homepage.instagram_url.present?
      # @resource = OEmbed::Providers.get(@homepage.instagram_url)
    end
  end
end
