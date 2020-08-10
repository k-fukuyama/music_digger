Rails.application.routes.draw do
  get 'artists/index'
  get 'artists/new'

  resources :genres, only: [:index, :new, :edit]
  resources :songs, only: [:index, :new, :edit]
  resources :discographies, only: [:index, :new, :edit]

  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :artists, only: [:index, :create]
      resources :genres, only: [:index, :create]
      resources :songs, only: [:index, :create]
      resources :discographies, only: [:index, :create]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
