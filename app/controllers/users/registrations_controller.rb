class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
  end

  private

  def sign_up_params
    allow = %i[email password password_confirmation username]
    params.require(resource_name).permit(allow)
  end
end
