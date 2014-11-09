class FinalsController < ApplicationController

  def index
    p cookies[:rdio_oauth_token].to_s
    p cookies[:rdio_oauth_token_secret].to_s
    rdio_api = RdioApi.new(:consumer_key => ENV["RDIO_CLIENT_ID"],
                            :consumer_secret => ENV["RDIO_CLIENT_SECRET"],
                            :access_token => cookies[:rdio_oauth_token],
                            :access_secret => cookies[:rdio_oauth_token_secret])
    p rdio_api.currentUser

    @rdio_user = rdio_api.currentUser
  end

end