class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:name, :position, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :position)
  end
  
  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
