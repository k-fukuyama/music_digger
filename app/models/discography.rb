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
      song.assign_attributes(
        {
          title: song_info['title'],
          producer_id: song_info['producer'],
          composer_id: song_info['composer'],
          lyricist_id: song_info['lyricist'],
          vocalist_id: song_info['vocalist'],
          guitarist_id: song_info['guitarist'],
          bassist_id: song_info['bassist'],
          drummer_id: song_info['bassist'],
          keyboardist_id: song_info['keyboardist'],
          min: song_info['min'],
          sec: song_info['sec']
        }
      )

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

  def set_new_artist_id(artist_name)
    self.artist_id = Artist.find_by(name: artist_name).id
  end
end
