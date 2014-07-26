# encoding: utf-8
class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters, :only => [:create]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :invitation_code) }
  end

end
