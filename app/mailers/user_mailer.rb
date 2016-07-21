class UserMailer < ApplicationMailer

  default from: 'notifications@example.com'

  def goodbye_email(user)
    @user = user
    mail(to: @user.email, subject: "Good-Bye, it's been a slice")
  end
end
