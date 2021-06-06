module V1
  module Services
    class DiscographyService
      class << self
        def create!(discography, song_infos)
          artist_id = Artist.find_by(id: discography[:artist])&.id
          return if artist_id.blank?

          discography = Discography.new(
            artist_id: artist_id,
            discography_type: discography[:discography_type],
            title: discography[:title],
            explanation: discography[:explanation],
            sales_start_at: discography[:sales_start_at],
            label: discography[:label]
          )

          ActiveRecord::Base.transaction do
            discography.save!
            id = Song.last&.id
            songs = []
            song_infos.each_with_index do |song_info, index|
              if index == 0 && id.present?
                id += 1
              elsif index == 0
                id = 1
              else
                id = songs.last.id + 1
              end

              now = Time.zone.now
              song = Song.new(
                id: id,
                track_number: song_info[:track_number],
                title: song_info[:title],
                discography_id: discography.id,
                artist_id: artist_id,
                producer_id: song_info[:producer_id],
                lyricist_id: song_info[:lyricist_id],
                composer_id: song_info[:composer_id],
                vocalist_id: song_info[:vocalist_id],
                bassist_id: song_info[:bassist_id],
                guitarist_id: song_info[:guitarist_id],
                drummer_id: song_info[:drummer_id],
                keyboardist_id: song_info[:keyboardist_id],
                created_at: now,
                updated_at: now
              )

              songs << song
            end
            songs = songs.map(&:attributes)
            Song.insert_all(songs)
          end
        end
      end
    end
  end
end
