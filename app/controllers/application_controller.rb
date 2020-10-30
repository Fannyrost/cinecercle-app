class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include Pundit

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:pseudo, :photo, :email, :password)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:pseudo, :photo, :email, :password, :current_password)}
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
