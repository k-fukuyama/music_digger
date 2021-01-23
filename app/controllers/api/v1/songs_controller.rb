class Api::V1::SongsController < ApplicationController
  def index

  end

  def create
  end

  def search
    artist = Artist.find(params[:artist_id])
    return unless artist.present?
    render json: artist.songs
  end
end
