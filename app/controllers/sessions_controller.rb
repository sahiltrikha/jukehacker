class SessionsController < ApplicationController
  
  def create
    user = Host.find_by(email: params[:email])
    if user && ( user.authenticate(params[:password])  )
      # session[:user_id] = user.id
      # session[:superuser] = user.superuser
      redirect_to(host_path(user)) 
    else
      session[:message] = "This email and password combination does not exist"
      session[:email] = params[:email]
      redirect_to(:back)
    end
  end 

end