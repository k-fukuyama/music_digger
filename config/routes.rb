Rails.application.routes.draw do
  get 'artists/index'
  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :artists, only: [:index]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
