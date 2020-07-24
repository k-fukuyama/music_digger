class Artist < ApplicationRecord
  validates :name, presence: true
  validates :gender, presence: true

  has_many :artist_genres, dependent: :destroy
  has_many :genres, through: :artist_genres

  def set_birth_day(birth)
    self.birth_year = birth.year
    self.birth_month = birth.month
    self.birth_day = birth.day
  end
end
