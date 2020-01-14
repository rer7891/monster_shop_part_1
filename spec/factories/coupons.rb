FactoryBot.define do
  factory :random_coupon, class: Coupon do
    name              {Faker::FunnyName.name}
    code              {Faker::Code.asin}
    percent           {0.35}
    used?             {false}
    active            {true}
    association       :merchant, factory: :jomah_merchant
  end

  factory :coupon_1, class: Coupon do
   name      {"Holiday Sale"}
   code      {"HOLIDAY1"}
   percent?  {0.40}
   used?     {true}
   active    {true}
   association       :merchant, factory: :jomah_merchant
 end
end
