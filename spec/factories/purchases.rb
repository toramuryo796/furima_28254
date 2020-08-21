FactoryBot.define do
  factory :purchase do
    postal_code    {"123-4567"}
    origin_area_id {2}
    city           {"藤沢市"}
    house_number   {"菖蒲沢894-1"}
    building_name  {"エスペランサ桜301"}
    phone_number   {"02345678910" }
    association    :user
    association    :item
  end
end
