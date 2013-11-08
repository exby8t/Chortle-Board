require 'date'
class SystemController < ApplicationController
  layout 'system'


  def index

  end

  def capture
    
    members = Member.all
    today = Date.today

    members.each do | member | 

      history = History.find_or_create_by_member_id_and_year_and_week(member.id, today.year, today.cweek)
      history.quota = member.required_points
      history.points = member.current_points
      history.save

    end

    history_for_week = History.find_all_by_year_and_week(today.year, today.cweek)
    render json: history_for_week

    
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
