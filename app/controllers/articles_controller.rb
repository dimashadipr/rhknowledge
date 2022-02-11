# frozen_string_literal: true

class ArticlesController < WebController
  def index
    @resource_pages = ResourcePage.search(params)
                                  .order(created_at: :desc)
                                  .page(params[:page])
                                  .per(5)
  end

  def landing
    code = params[:id]
    navigations = Navigation.where(code: code)
    params[:navigation_ids] = navigations.map(&:id)

    @resource_pages = ResourcePage.search(params)
                                  .order(created_at: :desc)
                                  .page(params[:page])
                                  .per(5)
  end

  def show_page
    @resource_page = ResourcePage.find_by(slug: params[:slug])
    @recent_articles = ResourcePage.where.not(id: @resource_page&.id)
                                   .order(created_at: :desc)
                                   .limit(4)
  end
end
