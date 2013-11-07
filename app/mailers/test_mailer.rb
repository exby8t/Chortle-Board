class TestMailer < ActionMailer::Base
  default from: "test mail <broadcaster@exby8t.com>"

  def test_mail
  	mail(to: "jonathan@arpcentral.net", subject: 'Test from Chortle')
  end
end
