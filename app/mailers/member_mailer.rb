class MemberMailer < ActionMailer::Base
  default from: "Chortle Broadcaster <broadcaster@exby8t.com>"


  def todo_status_message(member)
  	@member = member

  	mail(to: @member.email, subject: 'Your current status')

  end
end
