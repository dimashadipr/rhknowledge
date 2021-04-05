# frozen_string_literal: true

class WebController < ApplicationController
  before_action :set_locale
  after_action :track_action

  helper_method :resources_categories, :latest_resources, :navigation_items

  # around_action :switch_locale
  #
  # def switch_locale(&action)
  #   locale = params[:locale] || I18n.default_locale
  #   I18n.with_locale(locale, &action)
  # end

  def resources_categories
    Source.includes(:resource_details)
  end

  def latest_resources
    ResourcePage.order(created_at: :desc).limit(3)
  end

  def navigation_items
    @navigation_items ||= Navigation.where(navigation_id: nil).order(position: :asc)
  end

  private

  def track_action
    ahoy.track "Viewed #{controller_name}##{action_name}", request.filtered_parameters
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
