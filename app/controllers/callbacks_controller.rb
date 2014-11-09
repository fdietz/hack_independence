class CallbacksController < ApplicationController
  def show
    if params[:id]

    else
      @callback = true
      @provider = params[:provide]
      auth = request.env['omniauth.auth']
      case @provider
        when "spotify"
          cookies[:spotify] = true
          cookies[:spotify_token] = auth.to_json
          p "*"*50
          p "Welcome back from spotify"
          p auth.to_s
          p "*"*50
          #save the spotify token in the session
        when "rdio"
          p params
          cookies[:rdio] = true
          cookies[:rdio_token] = auth.to_json
          cookies[:rdio_oauth_token] = auth.extra.access_token.params["oauth_token"]
          cookies[:rdio_oauth_token_secret] = auth.extra.access_token.params["oauth_token_secret"]

          puts "RDIO TOKEN #{cookies[:rdio_token].inspect}"
          p "*"*50
          p "Welcome back from rdio"
          p auth.to_s
          p "*"*50
          #save the rdio token in the session
          #redirect_to "imports#show"
      end
      @spotify = cookies[:spotify]
      @rdio = cookies[:rdio]

      redirect_to import_url("spotify") and return if @spotify && @rdio
    end
  end
end
