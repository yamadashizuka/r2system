# coding: utf-8
class R2mailer < ActionMailer::Base
  default from: "Sankai_Kazutaka@ogis-ri.co.jp"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.r2mailer.sendRepairOrderMail.subject
  #
  def sendRepairOrderMail(emails, repair)

    @repair = repair

    mail to: emails, subject: "Information from R2 system"

    return self
    
  end

end
