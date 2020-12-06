class Discography < ApplicationRecord
  has_many :songs
  belongs_to :artist

  enum type: { シングル: 0, アルバム: 1 }

  def set_play_length(songs)
    min = 0
    sec = 0

    songs.each do |song|
      min += song.min
      sec += song.sec
    end

    self.play_length= Time.at((min * 60) + sec).utc.strftime('%X')
  end

  def infos_of_song_and_artists
    self.songs.map do |song|
      {
        id: song.id,
        track_number: song.track_number,
        title: song.title,
        producer: song.producer&.name,
        composer: song.composer&.name,
        lyricist: song.lyricist&.name,
        vocalist: song.vocalist&.name,
        drummer: song.drummer&.name,
        guitarist: song.guitarist&.name,
        bassist: song.bassist&.name,
        keyboardist: song.keyboardist&.name,
        min: song.min,
        sec: song.sec
      }
    end
    .sort_by{|info| info[:track_number]}
  end

  def update_song_infos(song_infos)
    save_target_songs = []
    song_infos.each do |song_info|
      song_info['artist_id'] = artist_id

      keys = song_info.keys
      song = songs.select{|song| song['id'] == song_info['id']}.first || set_new_song(song_info)

      song.fetch_artist_names_of_hash.keys.each do |key|
        next if song_info[key].nil?

        if song.fetch_artist_names_of_hash[key] != song_info[key]
          if song_info[key].empty?
            song[song.return_reladtion_columun_name(key)] = nil
          else
            artist_id = Artist.find_by(name: song_info[key]).id
            song[song.return_reladtion_columun_name(key)] = artist_id
          end
        end
      end

      song.fetch_artist_names_of_hash.keys.each{|key| keys.delete(key)}
      keys.each do |key|
        next if key == 'id'
        if song["#{key}"] != song_info["#{key}"]
          song["#{key}"] = song_info["#{key}"]
        end
      end

      save_target_songs << song
    end

    save_target_songs.map(&:save)
  end

  def set_new_song(song_info)
    song = Song.new
    song.set_song_params(song_info)
    song.assign_attributes({discography_id: id, artist_id: artist_id})
    song
  end

end
