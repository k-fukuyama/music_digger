module V1
  class DiscographiesApi < Grape::API
    resources :discographies do
      desc 'get discographies'
      get do
        present Services::DiscographyService.fetch_discographies(params[:search_word]), with: Entities::DiscographyEntity
      end

      desc 'pots discography'
      post do
        Services::DiscographyService.create!(params[:discography], params[:song_infos], params[:grammy_flg])

        present ({ isCreated: true })
      end
    end
  end
end
