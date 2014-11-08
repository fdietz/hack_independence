Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"], scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
  provider :rdio_oauth2, ENV["RDIO_CLIENT_ID"], ENV["RDIO_CLIENT_SECRET"]
end
