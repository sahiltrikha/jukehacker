class HostController < ApplicationController

  def show
  end 

  def create
    @host = Host.new(host_params)
    if @host.save
      session["host_id"]=@host_id
      redirect_to host_path(@host)
    else 
      render(:new)
    end 
    
  end 


  def authenticate
    unless logged_in?
      redirect_to login_path
    end
  end

  def authorize
    unless current_user == @user
      redirect_to login_path
    end
  end

end 
