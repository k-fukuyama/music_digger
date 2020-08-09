class Discography < ApplicationRecord
  def set_play_length(songs)
    min = 0
    sec = 0

    songs.each do |song|
      min += song.min
      sec += song.sec
    end

    self.play_length= Time.at((min * 60) + sec).utc.strftime('%X')
  end
end
