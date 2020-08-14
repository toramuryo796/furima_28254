FactoryBot.define do
  factory :item do
    title           {Faker::Lorem.characters(number: 10)}
    explain         {Faker::Lorem.characters(number: 300)}
    price           {Faker::Number.within(range: 300..9999999)}
    category_id     {Faker::Number.within(range: 1..10)}
    status_id       {Faker::Number.within(range:1..6)}
    fee_id          {Faker::Number.within(range:1..2)}
    origin_area_id  {Faker::Number.within(range:1..47)}
    take_days_id    {Faker::Number.within(range:1..3)}
  end
end
