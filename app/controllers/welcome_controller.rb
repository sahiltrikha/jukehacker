class WelcomeController < ApplicationController
  def index
    @host = Host.new
    @files = Dir.entries("#{Rails.root}/app/assets/images/albums/").reject{|filename| filename =~ /^\.+/}
  end 
end
