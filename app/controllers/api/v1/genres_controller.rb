class Api::V1::GenresController < ApplicationController
  def create
    genre = Genre.new(name: genre_params[:name])

    if genre.save
      render json: genre, status: 200
    else
      render json: genre, status: 500
    end
  end

  private

  def genre_params
     params.require(:genre).permit(:name)
  end
end
