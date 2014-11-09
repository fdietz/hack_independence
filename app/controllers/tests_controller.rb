class TestsController < ApplicationController
  def show
    @json = [{ id: 1, name: "bla"}, { id: 2, name: "blub"}]
  end
end