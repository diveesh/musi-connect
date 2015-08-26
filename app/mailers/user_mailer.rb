class UserMailer < ActionMailer::Base
  default from: "contact@diveesh.com"

  def user_notification(user)
    @user = user
    mail(to: 'diveesh@gmail.com', subject: 'Someone just joined Stanford MusiConnect!')
  end
end
