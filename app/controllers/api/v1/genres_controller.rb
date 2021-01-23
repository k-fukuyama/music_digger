class Api::V1::GenresController < ApplicationController
  def index
    genres = Genre.all
    render json: genres
  end

  def create
    genre = Genre.new(name: genre_params[:name])

    if genre.save
      render json: genre, status: 200
    else
      render json: genre, status: 500
    end
  end

  def edit
    render json: Genre.find(params[:id])
  end

  def update
    genre = Genre.find(params[:id])
    genre.name = params[:name]
    if genre.save
      head :ok
    else
      render json: e.message, status: 500
    end
  end

  private

  def genre_params
     params.require(:genre).permit(:name)
  end
end
