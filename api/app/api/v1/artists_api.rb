module V1
  class ArtistsApi < Grape::API
    resources :artists do
      desc 'get artists'
      get '/' do
        artists = Services::ArtistService.fetch_all_artists
        present artists, with: Entities::ArtistEntity
      end
    end
  end
end
