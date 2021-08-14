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

        def fetch_by_id(id)
          artist = Artist.find_by(id: id)
          return if artist.nil?

          {
            id: artist.id,
            name: artist.name,
            birth_day: artist.build_birth_day_for_api,
            gender: artist.gender,
            country: artist.country
          }
        end

        def update(params)
          artist = Artist.find_by(id: params[:id])
          return false if artist.nil?

          params.delete(:id)
          birth = params.delete(:birth_day)
          birth = birth_builder(birth)

          artist.update(
            name: params[:name],
            gender: params[:gender],
            birth_year: birth[:year],
            birth_month: birth[:month],
            birth_day: birth[:day],
            country: params[:country]
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
