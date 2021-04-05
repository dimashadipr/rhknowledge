class Admin::LocalesController < AdminController
  def set_locale
    session[:locale_cms] = params[:locale_cms]
    I18n.locale          = session[:locale_cms].to_sym
    referrer_paths       = URI(request.referrer || site_root_path).path.split('/')

    if I18n.available_locales.include?(referrer_paths[1]&.to_sym)
      referrer_paths[1] = session[:locale_cms]
    end

    redirect_to referrer_paths.join('/')
  end
end
