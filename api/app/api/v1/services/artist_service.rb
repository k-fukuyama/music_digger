module V1
  module Services
    class ArtistService
      class << self
        def fetch_all_artists
          Artist.all
        end

        def create!(artist)
          birth_element = birth_builder(artist[:birth])
          Artist.create!(
            name: artist[:name],
            gender: artist[:gender],
            country: artist[:country],
            birth_year: birth_element[:year],
            birth_month: birth_element[:month],
            birth_day: birth_element[:day]
          )
        end

        private

        def birth_builder(birth)
          element = birth.split('-')
          {year: element[0], month: element[1], day: element[2]}
        end
      end
    end
  end
end
