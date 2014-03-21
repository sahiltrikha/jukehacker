class WelcomeController < ApplicationController
  def index
    @host = Host.new

  end 
end
