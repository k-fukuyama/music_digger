module V1
  module Entities
    class ArtistEntity < Grape::Entity
      expose :id
      expose :name
      expose :birth_year
      expose :birth_month
      expose :birth_day
      expose :gender
      expose :country
    end
  end
end
