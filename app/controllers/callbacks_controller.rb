class CallbacksController < ApplicationController
  def show
    @provider = params[:provide]
    case @provider
      when "spotify"
        cookies[:spotify] = true
        p "*"*50
        p "Welcome back from spotify"
        p "*"*50
        #save the spotify token in the session
      when "rdio"
        cookies[:rdio] = true
        p "*"*50
        p "Welcome back from rdio"
        p "*"*50
        #save the rdio token in the session
        #redirect_to "imports#show"
    end
    @spotify = cookies[:spotify]
    @rdio = cookies[:rdio]
  end
end
