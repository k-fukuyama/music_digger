FactoryBot.define do
  factory :song do
    title { 'test_song' }
    discography_id { discography.id }
    artist_id { discography.artist_id }
    track_number { 1 }

    association :discography
  end
end
