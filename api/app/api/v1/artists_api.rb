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
    end
  end
end
