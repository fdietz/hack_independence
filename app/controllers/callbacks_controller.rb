class CallbacksController < ApplicationController
  def show
    @provider = params[:provide]
    case @provider
      when "spotify"
        p "Welcome back from spotify"
        #save the spotify token in the session
      when "rdio"
        #save the rdio token in the session
        #redirect_to "imports#show"
    end
  end
end
