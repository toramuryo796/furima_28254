FactoryBot.define do
  factory :user do
    nickname              {"abe"}
    emial                 {"kkk@gamil.com"}
    password              {"123456"}
    password_confirmation {password}
    first_name            {"太郎"}
    family_nmae           {"阿部"}
    first_name_reading    {"タロウ"}
    family_name_reading   {"アベ"}
    birth_date            {"2000-01-01"}
  end
end