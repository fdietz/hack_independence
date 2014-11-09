class TestsController < ApplicationController
  def show
    # delete navigation helper
    cookies.delete :spotify
    cookies.delete :rdio
    cookies.delete :rdio_token
    cookies.delete :rdio_oauth_token
    cookies.delete :rdio_oauth_token_secret

    @json = [{ id: 1, name: "bla"}, { id: 2, name: "blub"}]
  end
end