class SongsController < ApplicationController

  get '/songs' do
    @song_list = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    erb :'/songs/new'
  end

  post '/songs' do
    @song = Song.create(:name => params["Name"])
    #binding.pry
    if !params["Artist Name"].empty?
      @new_artist = Artist.find_or_create_by(:name => params["Artist Name"])
      @song.artist = @new_artist
    elsif !params["genres"].empty?
      @genre = Genre.find_by_id(params["genres"])
      @song.genres = @genre
    end
    @song.save

    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    @sluggish = Song.find_by_slug(params[:slug])
  #binding.pry
    erb :'/songs/show'
  end
end
