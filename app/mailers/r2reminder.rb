#coding: UTF-8
class R2reminder < ActionMailer::Base
  default from: "yescsr2@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.r2mailer.sendRepairOrderMail.subject
  #
  def send_reminder_mail(user)

    @user = user

    mail bcc: user.email, subject: "【R2システム】当月分のご請求書の発行について"

    return self
    
  end


end
