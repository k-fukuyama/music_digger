class Api::V1::AlbumsController < ApplicationController
  def search
    artist = Artist.find(params[:artist_id])
    return unless artist.present?
    render json: artist.fetch_albums
  end
end
