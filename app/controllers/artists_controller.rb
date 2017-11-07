class ArtistsController < ApplicationController
  def index
    @artists = Artist.all
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render :new
    end
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])

    @artist.update(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render :edit
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    flash[:notice] = "Artist deleted."
    redirect_to artists_path
  end

  def songs_index
    @artist = Artist.find(params[:id])
    @songs = @artist.songs
    render template: 'songs/index'
  end

  def song
    @artist = Artist.find(params[:id])

    # Note that because ids are unique by table we can go directly to
    # Post.find — no need for @author.posts.find...
    @song = Song.find(params[:song_id])
    render template: 'songs/show'
  end


  private

  def artist_params
    params.require(:artist).permit(:name)
  end
end
