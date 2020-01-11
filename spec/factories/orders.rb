FactoryBot.define do
  factory :random_order, class: Order do
    name      {Faker::FunnyName.name}
    address   {Faker::Address.street_address}
    city      {Faker::Address.city}
    state     {Faker::Address.state_abbr}
    zip       {12345}
    association :user, factory: :regular_user
  end
end
