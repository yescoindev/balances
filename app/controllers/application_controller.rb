class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_current_user_json
  before_filter :set_current_user_addresses_json
  before_filter :setup_gon

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  def set_current_user_json
    @current_user_json = Rabl::Renderer.new(
      'users/current_user',
      (current_user || {}),
      view_path: 'app/views',
      format: 'json',
      scope: view_context
    ).render
  end

  def set_current_user_addresses_json
    sorted_addresses = if user_signed_in?
      current_user.addresses.order("NULLIF(name, '') ASC")
    else
      {}
    end
    @current_user_addresses_json = Rabl::Renderer.new(
      'addresses/show',
      sorted_addresses,
      view_path: 'app/views',
      format: 'json',
      scope: view_context
    ).render
  end

  def setup_gon
    gon.user_voice_url = 'http://balances.uservoice.com/forums/244164-suggestions'

    gon.default_fiat_currency = :usd
    gon.fiat_currencies = {
      usd: {
        name: 'US Dollar',
        short_name: 'usd',
        symbol: '$',
      },
      eur: {
        name: 'Euros',
        short_name: 'eur',
        symbol: '€',
      },
      gbp: {
        name: 'Pounds Sterling',
        short_name: 'gbp',
        symbol: '£',
      },
      jpy: {
        name: 'Japanese Yen',
        short_name: 'jpy',
        symbol: '¥',
      },
    }
  end

end
