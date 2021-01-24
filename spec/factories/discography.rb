FactoryBot.define do
  factory :discography do
    discography_type { 0 }
    title { 'test_discography' }
    artist_id { artist.id }

    association :artist
  end
end
