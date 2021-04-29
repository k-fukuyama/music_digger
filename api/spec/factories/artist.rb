FactoryBot.define do
  factory :artist do
    sequence(:name) { |n| "TEST_NAME#{n}"}
    sequence(:gender) { 1 }
  end
end
