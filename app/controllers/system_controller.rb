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
  end

  def send_warning
  end
end
