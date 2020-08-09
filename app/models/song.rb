class Song < ApplicationRecord
  def set_song_params(song_info, artist_ids_of_hash = nil)
    artist_ids_of_hash = fetch_some_artist_ids_of_hash(song_info) unless artist_ids_of_hash.present?

    self.assign_attributes(
      {
        title: song_info[:title],
        track_number: song_info[:track_number],
        producer_id: artist_ids_of_hash[:producer_id],
        composer_id: artist_ids_of_hash[:producer_id],
        lyricist_id: artist_ids_of_hash[:lyricist_id],
        bassist_id: artist_ids_of_hash[:bassist_id],
        guitarist_id: artist_ids_of_hash[:guitarist_id],
        keyboardist_id: artist_ids_of_hash[:keyboardist_id]
      }
    )
  end
end
