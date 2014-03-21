class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_filter :configure_permitted_parameters, if: :devise_controller?

  before_filter :debug


  def debug
    Rails.logger.info "======= Debugging Header ======="
    Rails.logger.info request.env["HTTP_AUTHORIZATION"].inspect
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) { |u| 
      u.permit(:name, :password, :password_confirmation, :current_password) 
    }
  end

  def json_request?
    request.format.json?
  end
end
