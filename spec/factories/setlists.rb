FactoryGirl.define do
  factory :setlist do
    sequence(:venue) { |n| "Pickled Onion #{n}" }
    sequence(:date) { |n| Date.today + n }
  end
end
