class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:username, :email, :first_name, :last_name, :password)
    end
  end

  def after_sign_in_path_for(resource)
    matches_path
  end

  def after_sign_up_path_for(resource)
    matches_path
  end
end
