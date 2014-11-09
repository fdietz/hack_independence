class CallbacksController < ApplicationController
  def show
    @provider = params[:provide]
    auth = request.env['omniauth.auth']
    case @provider
      when "spotify"
        cookies[:spotify] = true
        cookies[:spotify_token] = auth[:credentials][:token]
        p "*"*50
        p "Welcome back from spotify"
        p "*"*50
        #save the spotify token in the session
      when "rdio"
        cookies[:rdio] = true
        cookies[:rdio_token] = auth[:credentials][:token]
        p "*"*50
        p "Welcome back from rdio"
        p "*"*50
        #save the rdio token in the session
        #redirect_to "imports#show"
    end
    @spotify = cookies[:spotify]
    @spotify_token = cookies[:spotify_token]
    @rdio = cookies[:rdio]
    @rdio_token = cookies[:rdio_token]
  end
end
