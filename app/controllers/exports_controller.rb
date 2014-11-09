class ExportsController < ApplicationController

  respond_to :json

  def show
    p cookies[:rdio_oauth_token].to_s
    p cookies[:rdio_oauth_token_secret].to_s
    rdio_api = RdioApi.new(:consumer_key => ENV["RDIO_CLIENT_ID"],
                            :consumer_secret => ENV["RDIO_CLIENT_SECRET"],
                            :access_token => cookies[:rdio_oauth_token],
                            :access_secret => cookies[:rdio_oauth_token_secret])
    p rdio_api.currentUser

    query_string = "#{params[:artists]}, #{params[:name]}"
    puts "search for #{query_string}"
    search_result = rdio_api.search(query: query_string, types: "Track")
    # puts "result: #{search_result.inspect}"


    if search_result.present? && search_result["results"].present? && search_result["results"].first.present? && search_result["results"].first["key"]
      puts "TRACK ID FOUND: #{search_result['results'].first['key']}"
      render json: { track_id: search_result["results"].first["key"] }
    else
      puts "SKIP TRACK: #{query_string}"
      render json: { status: "error" }
    end
  end

  def create
    p cookies[:rdio_oauth_token].to_s
    p cookies[:rdio_oauth_token_secret].to_s
    rdio_api = RdioApi.new(:consumer_key => ENV["RDIO_CLIENT_ID"],
                            :consumer_secret => ENV["RDIO_CLIENT_SECRET"],
                            :access_token => cookies[:rdio_oauth_token],
                            :access_secret => cookies[:rdio_oauth_token_secret])
    p rdio_api.currentUser

    # playlist = params[:playlist].with_indifferent_access
    name = params[:name]
    track_ids = params[:track_ids]

    # track_ids = []
    # tracks.each do |track|
    #   query_string = "#{track[:artists]}, #{track[:name]}"
    #   puts "search for #{query_string}"
    #   search_result = rdio_api.search(query: query_string, types: "Track")
    #   # puts "result: #{search_result.inspect}"


    #   if search_result.present? && search_result["results"].present? && search_result["results"].first.present? && search_result["results"].first["key"]
    #     track_ids << search_result["results"].first["key"]
    #     puts "TRACK ID FOUND: #{search_result['results'].first['key']}"
    #   else
    #     puts "SKIP TRACK: #{query_string}"
    #   end
    # end

    result = rdio_api.createPlaylist(:name => name, description: name, :tracks => track_ids.join(","))

    render json: result
  end

end
