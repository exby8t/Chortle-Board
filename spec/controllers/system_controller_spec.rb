require 'spec_helper'

describe SystemController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'ping'" do
    it "returns http success" do
      get 'ping'
      response.should be_success
    end
  end

  describe "GET 'send_reminder'" do
    it "returns http success" do
      get 'send_reminder'
      response.should be_success
    end
  end

  describe "GET 'send_status'" do
    it "returns http success" do
      get 'send_status'
      response.should be_success
    end
  end

  describe "GET 'send_warning'" do
    it "returns http success" do
      get 'send_warning'
      response.should be_success
    end
  end

end
