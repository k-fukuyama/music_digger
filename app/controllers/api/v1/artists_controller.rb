class Api::V1::ArtistsController < ApplicationController
  def index
  artists = if params[:search_params].present?
      Artist.where('name like ?', "%#{params[:search_params]}%")
    else
      artists = Artist.all
    end

    render json: artists
  end

  def create
    ActiveRecord::Base.transaction(requires_new: true) do
      artist = Artist.new(name: artist_params[:name], gender: artist_params[:gender], country: artist_params[:country], country: artist_params[:country])

      raise ActiveRecord::Rollback unless artist.save && artist.create_artist_genre(params[:genre_ids])

      render json: artist, status: 200
    rescue ActiveRecord::Rollback
      render json: e.message, status: 500
    end
  end

  private

  def artist_params
     params.require(:artist).permit(:name, :birth, :gender, :country)
  end
end
