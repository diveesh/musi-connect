class UserMailer < ActionMailer::Base
  default from: "contact@diveesh.com"

  def user_notification(user)
    @user = user
    mail(to: 'diveesh@gmail.com', subject: 'Someone just joined Stanford MusiConnect!')
  end

  def password_change_notification(user, password)
    @user = user
    @password = password
    mail(to: user.email_address, subject: 'Password Reset')
  end
end
