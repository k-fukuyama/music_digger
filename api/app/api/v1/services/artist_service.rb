module V1
  module Services
    class ArtistService
      class << self
        def fetch_all_artists
          Artist.all
        end
      end
    end
  end
end
