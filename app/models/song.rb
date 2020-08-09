class Song < ApplicationRecord
  def set_song_params(song_info, artist_ids_of_hash = nil)
    artist_ids_of_hash = fetch_some_artist_ids_of_hash(song_info) unless artist_ids_of_hash.present?
    song_min = song_info[:min]
    song_sec = song_info[:sec]

    self.assign_attributes(
      {
        title: song_info[:title],
        track_number: song_info[:track_number],
        producer_id: artist_ids_of_hash[:producer_id],
        composer_id: artist_ids_of_hash[:producer_id],
        lyricist_id: artist_ids_of_hash[:lyricist_id],
        bassist_id: artist_ids_of_hash[:bassist_id],
        guitarist_id: artist_ids_of_hash[:guitarist_id],
        keyboardist_id: artist_ids_of_hash[:keyboardist_id],
        min: song_min.present? ? song_min : 0,
        sec: song_sec.present? ? song_sec : 0
      }
    )
  end

  def fetch_some_artist_ids_of_hash(song_info)
    artists = Artist.where(
      name: [
      song_info[:producer],
      song_info[:composer],
      song_info[:lyricist],
      song_info[:vocalist],
      song_info[:bassist],
      song_info[:guitarist],
      song_info[:drummer],
      song_info[:keyboardist]
      ]
    ).select(:id, :name)

    ids_of_hash = {}
    artists.each do |artist|
      ids_of_hash[:producer_id] = artist.id if song_info[:producer] == artist.name
      ids_of_hash[:composer_id] = artist.id if song_info[:composer] == artist.name
      ids_of_hash[:lyricist_id] = artist.id if song_info[:lyricist] == artist.name
      ids_of_hash[:bassist_id] = artist.id if song_info[:bassist] == artist.name
      ids_of_hash[:guitarist_id] = artist.id if song_info[:guitarist] == artist.name
      ids_of_hash[:keyboardist_id] = artist.id if song_info[:keyboardist] == artist.name
    end

    ids_of_hash
  end
end
