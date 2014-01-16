require 'test_helper'

class R2mailerTest < ActionMailer::TestCase
  test "sendRepairOrderMail" do
    mail = R2mailer.sendRepairOrderMail
    assert_equal "Sendrepairordermail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
