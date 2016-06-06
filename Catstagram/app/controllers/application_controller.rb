class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # accessing unauthorized path redirects to custom 403 page
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to access_denied_path
  end
end
