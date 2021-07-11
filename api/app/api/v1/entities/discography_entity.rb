module V1
  module Entities
    class DiscographyEntity < Grape::Entity
      expose :id
      expose :title
      expose :label
      expose :sales_start_at
      expose :artist_name
    end
  end
end
