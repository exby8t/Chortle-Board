class LoginController < ApplicationController

  
  def index
  end

  def logout
    session[:member] = nil
    session[:administrator] = nil 
      flash[:message] = "You have been logged out."
      redirect_to login_path
  end

  def authenticate
  
    @member = Member.find_by_email_and_password(params[:email], params[:password])
    #@owner = Owner.find_authenticated(params[:netid], params[:password])
    #puts "checking #{params[:netid]} abd #{params[:password]} == #{@owner.nil?}"

    
    if @member

      session[:member] = {}
      session[:member][:id] = @member.id
      session[:member][:name] = @member.first_name

      redirect_to family_members_path(@member.family.id)
      
    else

      flash[:message] = "User not found."
      redirect_to login_path
    end

  end

  



end
