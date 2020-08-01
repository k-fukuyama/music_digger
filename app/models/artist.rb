class Artist < ApplicationRecord
  validates :name, presence: true
  validates :gender, presence: true

  has_many :artist_genres, dependent: :destroy
  has_many :genres, through: :artist_genres

  def set_birth_day(birth)
    birth_to_date = birth.to_date

    self.birth_year = birth_to_date.year
    self.birth_month = birth_to_date.month
    self.birth_day = birth_to_date.day
  end
end
