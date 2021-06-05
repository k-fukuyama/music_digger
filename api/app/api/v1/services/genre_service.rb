module V1
  module Services
    class GenreService
      class << self
        def create!(genre_name)
          Genre.create!(name: genre_name)
        end
      end
    end
  end
end
