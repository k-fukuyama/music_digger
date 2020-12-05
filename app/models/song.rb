class Song < ApplicationRecord
  belongs_to :discography
  belongs_to :artist
  belongs_to :producer, class_name: 'Artist',    foreign_key: :producer_id, optional: true
  belongs_to :vocalist, class_name: 'Artist',    foreign_key: :vocalist_id, optional: true
  belongs_to :lyricist, class_name: 'Artist',    foreign_key: :lyricist_id, optional: true
  belongs_to :composer, class_name: 'Artist',    foreign_key: :composer_id, optional: true
  belongs_to :bassist, class_name: 'Artist',     foreign_key: :bassist_id, optional: true
  belongs_to :guitarist, class_name: 'Artist',   foreign_key: :guitarist_id, optional: true
  belongs_to :drummer, class_name: 'Artist',     foreign_key: :drummer_id, optional: true
  belongs_to :keyboardist, class_name: 'Artist', foreign_key: :keyboardist_id, optional: true

  def set_song_params(song_info, artist_ids_of_hash = nil)
    artist_ids_of_hash = fetch_some_artist_ids_of_hash(song_info) unless artist_ids_of_hash.present?
    song_min = song_info[:min]
    song_sec = song_info[:sec]

    self.assign_attributes(
      {
        title: song_info[:title],
        track_number: song_info[:track_number],
        producer_id: artist_ids_of_hash[:producer_id],
        composer_id: artist_ids_of_hash[:composer_id],
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
      ids_of_hash[:vocalist_id] = artist.id if song_info[:vocalist] == artist.name
      ids_of_hash[:drummer_id] = artist.id if song_info[:drummer] == artist.name
      ids_of_hash[:composer_id] = artist.id if song_info[:composer] == artist.name
      ids_of_hash[:lyricist_id] = artist.id if song_info[:lyricist] == artist.name
      ids_of_hash[:bassist_id] = artist.id if song_info[:bassist] == artist.name
      ids_of_hash[:guitarist_id] = artist.id if song_info[:guitarist] == artist.name
      ids_of_hash[:keyboardist_id] = artist.id if song_info[:keyboardist] == artist.name
    end

    ids_of_hash
  end

  def fetch_artist_names_of_hash
    artist_names_of_hash = {}

    ['producer', 'composer', 'lyricist', 'vocalist', 'guitarist', 'bassist', 'drummer', 'keyboardist'].each do |key|
      case key
      when 'producer'
        artist_names_of_hash["#{key}"] = producer&.name
      when 'composer'
        artist_names_of_hash["#{key}"] = composer&.name
      when 'lyricist'
        artist_names_of_hash["#{key}"] = lyricist&.name
      when 'vocalist'
        artist_names_of_hash["#{key}"] = vocalist&.name
      when 'guitarist'
        artist_names_of_hash["#{key}"] = guitarist&.name
      when 'bassist'
        artist_names_of_hash["#{key}"] = bassist&.name
      when 'drummer'
        artist_names_of_hash["#{key}"] = drummer&.name
      when 'keyboardist'
        artist_names_of_hash["#{key}"] = keyboardist&.name
      end
    end

    artist_names_of_hash
  end

end
