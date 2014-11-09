class CallbacksController < ApplicationController
  def show
    @provider = params[:provide]
    auth = request.env['omniauth.auth']
    case @provider
      when "spotify"
        cookies[:spotify] = true
        cookies[:spotify_token] = auth
        p "*"*50
        p "Welcome back from spotify"
        p auth.to_s
        p "*"*50
        #save the spotify token in the session
      when "rdio"
        cookies[:rdio] = true
        cookies[:rdio_token] = auth
        p "*"*50
        p "Welcome back from rdio"
        p auth.to_s
        p "*"*50
        #save the rdio token in the session
        #redirect_to "imports#show"
    end
    @spotify = cookies[:spotify]
    @rdio = cookies[:rdio]
  end
end
