class HostsController < ApplicationController

  def show
    @current_party = Party.find_by("host_id = ? AND party_expiry > ?" , params[:id], Time.now())
    @past_parties = Party.where("host_id = ? AND party_expiry < ?" , params[:id], Time.now())
  end 

  def create

    @host = Host.new(host_params)
    cell_phone = params["host"]["cell_phone"].gsub(/[^0-9]/, "")
    user = User.find_by(phone_number: cell_phone)
    
    if user == nil
      new_user = User.create({ 
        first_name: params["host"]["first_name"],
        last_name: params["host"]["last_name"],
        phone_number: params["host"]["cell_phone"]
        })
      @host.user_id = new_user.id
    elsif 
      @host.user_id = user.id        
    end 


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

  private
  def host_params
    params.require(:host).permit(:first_name, :last_name, :email, :zip, :password, :password_confirmation)
  end


end 
