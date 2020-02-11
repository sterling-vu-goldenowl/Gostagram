class Users::RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    allow = %i[email password password_confirmation username name]
    params.require(resource_name).permit(allow)
  end
end
