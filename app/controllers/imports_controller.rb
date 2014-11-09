class ImportsController < ApplicationController
  def index
  end

  def show
    respond_to do |format|
      format.html

      format.json do
        retrieve_playlist
        render json: @spotify_playlist.to_json
      end
    end

    #try to find some stuff via rdio
    # p "RDIO ≈"
    # p cookies[:rdio_oauth_token].to_s
    # p cookies[:rdio_oauth_token_secret].to_s
    # rdio_api = RdioApi.new(:consumer_key => ENV["RDIO_CLIENT_ID"],
    #                         :consumer_secret => ENV["RDIO_CLIENT_SECRET"],
    #                         :access_token => cookies[:rdio_oauth_token],
    #                         :access_secret => cookies[:rdio_oauth_token_secret])
    # # p rdio_user.currentUser.to_s
    # p "search for "
    # search_result = rdio_api.search(query: "Michael Jackson, Bad", types: "Track")
    # p search_result["results"].first["key"]
  end

  private

  def retrieve_playlist
    spotify_user = RSpotify::User.new(JSON.parse(cookies[:spotify_token]))
    p spotify_user.email
    p spotify_user.country
    p spotify_user.product

    @spotify_playlist = []
    spotify_user.playlists.each do |pl|
      playlist = {}
      playlist["name"] = pl.name

      tracks = []
      pl.tracks.each do |t|
        track = {}
        track["name"] = t.name
    track["album"] = t.album.name

    artists = []
    t.artists.each do |a|
          artists << a.name
    end

    track["artists"] = artists.join(',')
    tracks << track
      end
      playlist["tracks"] = tracks

      @spotify_playlist << playlist
    end
    p "RESULT --------"
    puts (JSON.pretty_generate JSON.parse(@spotify_playlist.to_json))
    p "RESULT --------"
  end

end
