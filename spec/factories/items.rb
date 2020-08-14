FactoryBot.define do
  factory :item do
    title           {Faker::Lorem.word}
    explain         {Faker::Lorem.paragraph}
    price           {Faker::Number.within(range: 300..9999999)}
    category_id     {Faker::Number.within(1..10)}
    status_id       {Faker::Number.within(1..6)}
    fee_id          {Faker::Number.within(1..2)}
    origin_area_id  {Faker::Number.within(1..47)}
    take_days_id    {Faker::Number.within(1..3)}
  end
end
