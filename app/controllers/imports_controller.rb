class ImportsController < ApplicationController
  def index
  end

  def show
    cookies.delete :spotify
    cookies.delete :rdio
  end
end
