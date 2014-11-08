class ExportsController < ApplicationController

  def index
  end

  def show
    @provider = params[:id]
    raise ArgumentError unless %w(spotify rdio).include?(@provider)
  end
end
