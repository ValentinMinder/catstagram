class RegistrationsController < Devise::RegistrationsController

  protected

  # when signing up, redirected to edit profile
  # it allows to edit username, bio, avatar
  # it allows the user to be granted the 'user' right, too
  def after_sign_up_path_for(resource)
    edit_user_path(resource.id)
  end

  private

  # OVERRIDE OF DEVISE DEFAULTS
  # allows only theses params for sign up (defaults + username)
  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  # OVERRIDE OF DEVISE DEFAULTS
  # allows only theses params for account update (defaults)
  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
  end
end
