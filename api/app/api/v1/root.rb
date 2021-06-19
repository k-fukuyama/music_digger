module V1
  class Root < Grape::API
    prefix 'api'
    version :v1
    format :json

  rescue_from :all do |e|
    error_response(message: "Internal server error", status: 500)
  end

    mount V1::ArtistsApi
    mount V1::GenresApi
    mount V1::DiscographiesApi
  end
end
