module V1
  class ArtistsApi < Grape::API
    resources :artists do
      desc 'get artists'
      get '/' do
        artists = Services::ArtistService.fetch_all_artists
        present artists, with: Entities::ArtistEntity
      end

      desc 'pots artist'
      post do
        Services::ArtistService.create!(params[:artist])

        present ({ isCreated: true })
      end

      desc 'get artist by id'
      get '/:id' do
        artist = Services::ArtistService.fetch_by_id(params[:id])
        raise ActiveRecord::RecordNotFound if artist.nil?

        present artist, with: Entities::ArtistEntity
      end

      desc 'update artist'
      patch '/:id' do
        result = Services::ArtistService.update(params)
        raise ActiveRecord::RecordNotFound unless result

        present ({is_updated: result})
      end
    end
  end
end
