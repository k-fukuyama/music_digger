FactoryBot.define do
  factory :discography do
    discography_type { 1 }
    title { 'title' }
    sales_start_at { '20210625'.to_date }
    play_length { '0' }
  
    association :artist
  end
end
