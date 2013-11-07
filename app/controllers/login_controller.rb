class LoginController < ApplicationController

  def callback

    email = request.env["omniauth.auth"][:info][:email]

    @member = Member.find_by_email(email)
    #puts "checking #{params[:netid]} abd #{params[:password]} == #{@owner.nil?}"

    
    if @member

      session[:member] = {}
      session[:member][:id] = @member.id
      session[:member][:name] = @member.first_name
      session[:member][:family] = {:id => @member.family.id, :name => @member.family.name}

      if @member.admin?
        session[:member][:admin] = true
      end
      
      redirect_to home_path
      
    else

      flash[:message] = "User not found."
      redirect_to login_path
    end

  end
  
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
    #puts "checking #{params[:netid]} abd #{params[:password]} == #{@owner.nil?}"

    
    if @member
      flash[:notice] = "You have been logged in!"
      session[:member] = {}
      session[:member][:id] = @member.id
      session[:member][:name] = @member.first_name
      session[:member][:family] = {:id => @member.family.id, :name => @member.family.name}

      if @member.admin?
        session[:member][:admin] = true
      end
      
      redirect_to home_path
      
    else
      flash[:error] = "Username does not match!"
      flash[:message] = "User not found."
      redirect_to login_path
    end

  end

  



end
