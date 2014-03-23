require 'spec_helper'

describe HostsController do 

  describe "post #create" do 
    before do 
      @user = User.create({
        first_name: "Michael" ,
        last_name: "Wagner" , 
        phone_number: "6104414423" 
        })
    end
    
    context "WHEN Host Cell Phone exists on User Table" do 
      it "Creates a New Host with the User as the foreign Key" do 
        @params={"cell_phone"=>"6104414423","password"=>"winner","password_confirmation"=>"winner"}
        post :create, {host: @params}

        @user = User.find_by(phone_number: @params["cell_phone"])
        @host = Host.find_by(user_id: @user.id)

        expect(@user.id).to eq(@host.user_id)
      end

      it "removes the non-numerics when creating the account"do 
        @params={"cell_phone"=>"6?1%0*44K14423","password"=>"winner","password_confirmation"=>"winner"}
        post :create, {host: @params}

        @user = User.find_by(phone_number: "6104414423")
        @host = Host.find_by(user_id: @user.id)

        expect(@user.phone_number).to eq("6104414423")
      end 

    end 

    context "WHEN Host Cell Phone DOES NOTexists on User Table" do 
      it "Creates a New Host AND a New User" do 
        @params={"cell_phone"=>"6104414424","password"=>"winner","password_confirmation"=>"winner"}
        post :create, {host: @params}
        @user = User.find_by(phone_number: @params["cell_phone"])
        @host = Host.find_by(user_id: @user.id)

        expect(@user.id).to eq(@host.user_id)
      end 
    end

  end 

end 