FactoryBot.define do
  factory :item do
    title           {"あいうえお絵否定受けだふぇふイウレスskdjfkfher"}
    explain         {"かいくらああすへ津田でソニンのけヘアあづ雨おせasdjjfisafnjakshfmjns12443"}
    price           {"92357"}
    category_id     {8}
    status_id       {5}
    fee_id          {2}
    origin_area_id  {42}
    take_day_id    {3}
    association     :user
  end
end
