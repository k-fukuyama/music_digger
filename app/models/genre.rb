class Genre < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :artist_genres, dependent: :destroy
  has_many :artists, through: :artist_genres
end
