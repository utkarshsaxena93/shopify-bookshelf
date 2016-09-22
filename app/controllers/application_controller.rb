class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include PublicActivity::StoreController
  protect_from_forgery with: :exception

  before_action :authenticate_user!, :gravitarhash, :devise_configure_permitted_parameters, if: :devise_controller?

  def gravitarhash
    if current_user
      @gravitarhash = current_user.gravitarhash
    end
  end

  protected

  def devise_configure_permitted_parameters
    devise_parameter_sanitizer.permit(:accept_invitation) do |u|
      u.permit(:name, :position, :password, :password_confirmation,
               :invitation_token)
    end
  end

end
