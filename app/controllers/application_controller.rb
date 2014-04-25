class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale, :init_page_params

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/home', alert: exception.message
  end

  def set_locale
    I18n.locale = I18n.default_locale
  end

  def set_page_params(obj)
    @page_params = @page_params.merge obj
  end

  private
    def init_page_params
      @page_params = {}
      set_page_params foursquare: { oauth_token: ENV['FOURSQUARE_TOKEN'] }
    end

end
