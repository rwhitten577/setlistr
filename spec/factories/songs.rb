FactoryGirl.define do
  factory :song do
    sequence(:title) { |n| "Kickapoo #{n}" }
  end
end
