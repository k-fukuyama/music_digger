class Api::V1::ArtistsController < ApplicationController
  def index
    artists = Artist.all
    render json: artists
  end

  def create
    artist = Artist.new(name: artist_params[:name], gender: artist_params[:gender], country: artist_params[:country])
    artist.set_birth_day(artist_params[:birth].to_date)

    if artist.save
      render json: artist, status: 200
    else
      render json: artist, status: 500
    end
  end
end
