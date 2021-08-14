module V1
  class Root < Grape::API
    prefix 'api'
    version :v1
    format :json

  rescue_from :all do |e|
    error_response(message: "Internal server error", status: 500)
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    rack_response({ message: e.message, status: 404 }.to_json, 404)
  end

    mount V1::ArtistsApi
    mount V1::GenresApi
    mount V1::DiscographiesApi
  end
end
