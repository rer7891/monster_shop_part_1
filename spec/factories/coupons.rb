FactoryBot.define do
  factory :random_coupon, class: Coupon do
    sequence(:name)   {Faker::Hipster}
    code              {Faker::Code.asin}
    price             {rand(1..100)}
    used?             {false}
    association       :merchant, factory: :jomah_merchant
  end
end
