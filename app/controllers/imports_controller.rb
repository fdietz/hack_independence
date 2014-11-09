class ImportsController < ApplicationController
  def index
  end

  def show
    # delete navigation helper
    # cookies.delete :spotify
    # cookies.delete :rdio

    #Token check
    p "SPOTIFY TOKEN"
    p cookies[:spotify_token].to_s

    p "RDIO TOKENS"
    p cookies[:rdio_oauth_token].to_s
    p cookies[:rdio_oauth_token_secret].to_s

    #try to find some stuff via spotify
    p "SPOTIFY USER~"
    spotify_user = RSpotify::User.new(JSON.parse(cookies[:spotify_token]))
    p spotify_user.email
    p spotify_user.country
    p spotify_user.product


    #try to find some stuff via rdio
    p "RDIO ≈"
    p cookies[:rdio_oauth_token].to_s
    p cookies[:rdio_oauth_token_secret].to_s
    rdio_user = RdioApi.new(:consumer_key => ENV["RDIO_CLIENT_ID"],
                            :consumer_secret => ENV["RDIO_CLIENT_SECRET"],
                            :access_token => cookies[:rdio_oauth_token],
                            :access_secret => cookies[:rdio_oauth_token_secret])
    p rdio_user.currentUser.to_s
  end
end
