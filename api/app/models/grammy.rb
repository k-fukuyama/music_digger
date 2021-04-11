class Grammy < ApplicationRecord
  validates :artist_id, presence: true

  enum grammy_type: { 最優秀アルバム賞: 0, 最優秀レコード賞: 1, 最優秀楽曲賞: 2, 最優秀新人賞: 3 }

  belongs_to :artist
  belongs_to :discography, foreign_key: :album_id, optional: true
  belongs_to :genre
  belongs_to :song, foreign_key: :song_id, optional: true
end
