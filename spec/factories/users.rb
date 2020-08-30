FactoryBot.define do
  factory :user do
    nickname              { 'abe' }
    email                 { 'kkk@gamil.com' }
    password              { 'asd123' }
    password_confirmation { password }
    first_name            { '太郎' }
    family_name           { '阿部' }
    first_name_reading    { 'タロウ' }
    family_name_reading   { 'アベ' }
    birth_date            { '2000-01-01' }
  end
end
