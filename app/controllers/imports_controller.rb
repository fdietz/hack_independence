class ImportsController < ApplicationController
  def index
  end

  def show
    # delete navigation helper
    cookies.delete :spotify
    cookies.delete :rdio

    #Token check
    p "*"*50
    p cookies[:spotify_token].to_s
    p cookies[:rdio_token].to_s

    #try to find some stuff via spotify
    p "~"*50
    spotify_user = RSpotify::User.new(cookies[:spotify_token])
    p spotify_user.email


    #try to find some stuff via rdio
    p "≈"*50
    p cookies[:rdio_token]
    #rdio_user = RdioApi.new(:consumer_key => CONSUMER_KEY, :consumer_secret => CONSUMER_SECRET)
  end
end
