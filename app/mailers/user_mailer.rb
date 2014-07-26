class UserMailer < BaseMailer

  def password_reset(user, password)
    @user = user
    @password = password
    mail(:to => user.email, :subject => 'Password Reset Notification')
  end

end
