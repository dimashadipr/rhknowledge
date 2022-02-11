# frozen_string_literal: true

class AdminController < ActionController::Base
  layout 'admin'
  before_action :authenticate_user!
  skip_before_action :track_ahoy_visit
  before_action :set_paper_trail_whodunnit

  prepend_before_action :set_locale_cms

  def set_locale_cms
    if params[:locale_cms].blank? || !I18n.available_locales.include?(params[:locale_cms]&.to_sym)
      return
    end

    session[:locale_cms] = params[:locale_cms]
    I18n.locale          = session[:locale_cms].to_sym
  end

  def default_url_options
    { locale_cms: locale }
  end

  def locale
    session[:locale_cms] || I18n.locale
  end

  def not_authorised
    respond_to do |format|
      format.js {
        flash[:error] = 'Unauthorized'
        redirect_to admin_path
      }
      format.html {
        render 'admin/errors/401', status: 401, layout: false
      }
    end
  end

  rescue_from CanCan::AccessDenied do |e|
    flash[:warning] = e.message

    respond_to do |format|
      format.js { redirect_to root_path }
      format.html { redirect_back fallback_location: admin_path }
    end
  end
end
