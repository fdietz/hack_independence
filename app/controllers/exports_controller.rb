class ExportsController < ApplicationController

  respond_to :json

  def create
    p cookies[:rdio_oauth_token].to_s
    p cookies[:rdio_oauth_token_secret].to_s
    rdio_api = RdioApi.new(:consumer_key => ENV["RDIO_CLIENT_ID"],
                            :consumer_secret => ENV["RDIO_CLIENT_SECRET"],
                            :access_token => cookies[:rdio_oauth_token],
                            :access_secret => cookies[:rdio_oauth_token_secret])
    p rdio_api.currentUser

    playlist = params[:playlist].with_indifferent_access
    name = playlist[:name]
    tracks = playlist[:tracks]

    track_ids = []
    tracks.each do |track|
      query_string = "#{track[:artist]}, #{track[:song]}"
      puts "search for #{query_string}"
      search_result = rdio_api.search(query: query_string, types: "Track")
      # puts "result: #{search_result['results']}"
      puts "ID: #{search_result['results'].first['key']}"

      track_ids << search_result["results"].first["key"]
    end

    result = rdio_api.createPlaylist(:name => name, description: name, :tracks => track_ids.join(","))

    render json: result
  end

end
