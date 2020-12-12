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

  def set_song_params(song_info)
    self.assign_attributes(
      {
        title: song_info[:title],
        track_number: song_info[:track_number],
        producer_id: song_info[:producer_id],
        vocalist_id: song_info[:vocalist_id],
        drummer_id: song_info[:drummer_id],
        composer_id: song_info[:composer_id],
        lyricist_id: song_info[:lyricist_id],
        bassist_id: song_info[:bassist_id],
        guitarist_id: song_info[:guitarist_id],
        keyboardist_id: song_info[:keyboardist_id],
        min: song_info[:min].presence || 0,
        sec: song_info[:sec].presence || 0
      }
    )
  end

  def set_same_artists(song_info)
    self.assign_attributes(
      {
        producer_id: song_info[:producer_id],
        composer_id: song_info[:composer_id],
        lyricist_id: song_info[:lyricist_id],
        vocalist_id: song_info[:vocalist_id],
        drummer_id: song_info[:drummer_id],
        bassist_id: song_info[:bassist_id],
        guitarist_id: song_info[:guitarist_id],
        keyboardist_id: song_info[:keyboardist_id]
      }
    )
  end
end
