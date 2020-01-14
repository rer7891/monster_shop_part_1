FactoryBot.define do
  factory :random_coupon, class: Coupon do
    name              {Faker::FunnyName.name}
    code              {Faker::Code.asin}
    percent           {rand(1..100)}
    used?             {false}
    active            {true}
    association       :merchant, factory: :jomah_merchant
  end
end
