class HostsController < ApplicationController

  def show
    @current_party = Party.find_by("host_id = ? AND party_expiry > ?" , params[:id], Time.now())
    @past_parties = Party.where("host_id = ? AND party_expiry < ?" , params[:id], Time.now())
    
    
    @past_parties.each do |party|
    
      #Option 1:  Create a by_sql Statement.  Can only get columns from a single title. 
      # songs_played = Song.find_by_sql("SELECT songs.*, played_songs.create_time FROM songs INNER JOIN played_songs ON songs.id=played_songs.song_id WHERE played_songs.party_id = ?", party)

      # Option 2:  Create an a Joined Object.  Can only get the columns from a single title
      # songs_played = PlayedSong.select("songs.*").joins(:song).where("party_id = ? ", party.id)
    
      #Option 3:  Create a SQL Query and a PG Object
      # query = "SELECT * FROM songs INNER JOIN played_songs ON songs.id=played_songs.song_id WHERE played_songs.id = #{party.id}"
      # songs_played = ActiveRecord::Base.connection.execute(query)
      
      # Option 4:  Capture Song ID and use 
      songs_played = PlayedSong.where("party_id = ? ", party.id).pluck(:song_id)
      songs_played_time = PlayedSong.where("party_id = ? ", party.id).pluck(:created_at)

      party.class.module_eval {attr_accessor :songs}
      party.class.module_eval {attr_accessor :songs_time}
      if songs_played.blank?
      else 
        party.songs_time = []
        party.songs_time << songs_played_time
        party.songs_time.flatten!
        song_details = Song.find(songs_played)
        party.songs = []
        party.songs << song_details
        party.songs.flatten!
      end 
    end 


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
