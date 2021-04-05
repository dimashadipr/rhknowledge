# frozen_string_literal: true

class LocalesController < WebController
  def set_locale
    I18n.locale      = params[:locale]
    referrer_paths   = URI(request.referrer || site_root_path).path.split('/')

    if I18n.available_locales.include?(referrer_paths[1]&.to_sym)
      referrer_paths[1] = I18n.locale
    end

    redirect_to referrer_paths.join('/')
  end

  private

  def site_root_path
    redirected_root_path
  end
end
