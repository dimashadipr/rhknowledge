# frozen_string_literal: true

class Admin::ImageArticlesController < AdminController
  skip_forgery_protection
  def create
    image_article = ImageArticle.new
    image_article.file = params[:file]
    image_article.save

    render json: { location: image_article.file.url }, content_type: 'text / html'
  end
end
