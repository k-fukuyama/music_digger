class Api::V1::DiscographiesController < ApplicationController
  def index
  end

  def create
    discography = Discography.new(discography_params)
    artist_id = Artist.find_by(name: params[:discography][:artist])&.id
    raise StandardError unless artist_id.present?
    discography.artist_id = artist_id

    artist_ids_of_hash = Song.new.fetch_some_artist_ids_of_hash(params[:song_infos][0]) if params[:set_same_artist]

    ActiveRecord::Base.transaction(requires_new: true) do
      songs = []
      params[:song_infos].each do |song_info|
        song = Song.new(artist_id: artist_id)
        song.set_song_params(song_info, artist_ids_of_hash)

        songs << song
      end

      discography.set_play_length(songs)

      result_of_discography_save = discography.save

      results_of_song_save = []
      songs.each do |song|
        song.discography_id = discography.id
        results_of_song_save << song.save
      end

      raise ActiveRecord::Rollback unless result_of_discography_save && results_of_song_save.exclude?(false)

      head :ok
    rescue ActiveRecord::Rollback, StandardError => e
      render json: e.message, status: 500
    end
  end

  def edit
    discography = Discography.find(params[:id])
    infos = discography.infos_of_song_and_artists

    respond_to do |f|
      f.json { render json: [discography: discography, artist: discography.artist, infos: infos] }
    end
  end

  def update
    discography = Discography.find(params[:discography][:id])
    discography.assign_attributes(discography_params)

    ActiveRecord::Base.transaction(requires_new: true) do

      raise ActiveRecord::Rollback unless discography.update_song_infos(params[:song_infos]).exclude?(false) && discography.save!

      head :ok
    rescue ActiveRecord::Rollback, StandardError => e
      render json: e.message, status: 500
    end
  end

  private

  def discography_params
     params.require(:discography).permit(
       :title, :producer_id, :country, :sales_start_at, :explanation, :discography_type, :label, :artist_id, :chart
     )
  end

  def song_params
    params.require(:songs).permit(:title, :chart, :sales_start_at)
  end
end
