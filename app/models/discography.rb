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
  end
end
