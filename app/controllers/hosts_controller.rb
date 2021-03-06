class HostsController < ApplicationController

  def show
    authorize()
    @current_party = Party.find_by("host_id = ? AND party_expiry > ?" , params[:id], Time.now())
    @past_parties = Party.where("host_id = ? AND party_expiry < ?" , params[:id], Time.now())
    @party = Party.new    
    @song_art = []
    
    @past_parties.each do |party|    
      #Step 1:  Add to the Song Art Array 
        party.played_songs.each do |played_song|
          @song_art << played_song.song.album_art
        end 

      songs_played = PlayedSong.where("party_id = ? ", party.id).pluck(:song_id)
      songs_played_time = PlayedSong.where("party_id = ? ", party.id).pluck(:created_at)
      
      #Step 2: Update the Party Object
      party.class.module_eval {attr_accessor :songs}
      party.class.module_eval {attr_accessor :songs_time}
      
      #Step 3:  Add the Play Time and Song Details to the Party Object
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
    
    unless @song_art.length<=5
      @song_art = @song_art[-5..-1]
    end
  end 

  def create

    @host = Host.new(host_params)
    cell_phone = params["host"]["cell_phone"].gsub(/[^0-9]/, "")
    user = User.find_by(phone_number: cell_phone)
    
    if user == nil
      new_user = User.create({ 
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
      redirect_to request.referer
    end 

  end 


  def authenticate
    unless logged_in?
      redirect_to root_path
    end
  end

  def authorize
    unless current_host == params[:id].to_i
      redirect_to root_path
    end
  end

  private
  def host_params
    params.require(:host).permit(:first_name, :last_name, :email, :zip, :password, :password_confirmation)
  end


end 
