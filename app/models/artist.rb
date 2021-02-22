class Artist < ApplicationRecord
  validates :name, presence: true
  validates :gender, presence: true

  has_many :artist_genres, dependent: :destroy
  has_many :genres, through: :artist_genres
  has_many :songs
  has_many :discographies

  enum gender: { 男性: 0, 女性: 1, その他: 2 }

  def set_birth_day(birth)
    birth_to_date = birth.to_date

    self.birth_year = birth_to_date.year
    self.birth_month = birth_to_date.month
    self.birth_day = birth_to_date.day
  end

  def create_artist_genre(genre_ids)
    return true unless genre_ids.present?

    genre_ids.each do |genre_id|
      ArtistGenre.create(artist_id: self.id, genre_id: genre_id)
    end
  end

  def fetch_albums
    discographies.where(discography_type: 1)
  end

  def self.artist_names_and_ids_of_hash
    hash = {}
    all.select(:id, :name).map{|artist| hash["#{artist.name}"] = artist.id}
    hash
  end
end
