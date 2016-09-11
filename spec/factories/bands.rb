FactoryGirl.define do
  factory :band do
    sequence(:name) { |n| "Maggot Death #{n}" }
  end
end
