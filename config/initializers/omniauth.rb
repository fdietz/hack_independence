Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"], 
  scope: 'user-read-private user-library-modify user-library-read streaming playlist-modify-private playlist-modify-public playlist-read-private'
  provider :rdio_oauth2, ENV["RDIO_CLIENT_ID"], ENV["RDIO_CLIENT_SECRET"]
end
