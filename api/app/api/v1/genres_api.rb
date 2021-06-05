module V1
  class GenresApi < Grape::API
    resources :genres do
      desc 'pots genre'
      post do
        Services::GenreService.create!(params[:genre][:name])

        present ({ isCreated: true })
      end
    end
  end
end
