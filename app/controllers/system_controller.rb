class SystemController < ApplicationController
  layout 'system'


  def index

  end

  def send_test
    TestMailer.test_mail().deliver
    render json: params
  end


  def ping
    render json: "pong"
  end

  def send_reminder
  end

  def send_status
    @messages = []
    members = Member.all
    
    members.each do | member | 
      
      unless member.todos.incompleted.empty?
        puts "sending status to #{member.first_name}"
        puts MemberMailer.instance_methods(false)
        MemberMailer.todo_status_message(member).deliver

        @messages << {:name => "#{member.first_name} #{member.last_name}", :count => member.todos.incompleted.count}
      end

    end

    render json: @messages

  end

  def send_warning
  end
end
