# coding: utf-8
class Users::PasswordsController < Devise::PasswordsController

  protected

  def after_sending_reset_password_instructions_path_for(resource_name)
    new_user_password_path
  end

end
