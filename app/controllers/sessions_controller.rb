class SessionsController < ApplicationController
  
  def create
    host = Host.find_by(email: params[:email])
    if host && ( host.authenticate(params[:password])  )
      session[:host_id] = host.id
      session[:first_name] = host.first_name
      redirect_to(host_path(host)) 
    else
      session[:message] = "This email and password combination does not exist"
      session[:email] = params[:email]
      redirect_to(:back)
    end
  end 

  def destroy
    session[:first_name] = nil
    session[:host_id] = nil
    session[:user_id] = nil
    session[:message] = nil
    session[:email] = nil
    redirect_to("/")
  end 

end