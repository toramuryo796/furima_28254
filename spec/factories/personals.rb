FactoryBot.define do
  factory :personal do
    first_name            {'太郎'}
    family_name           { '阿部' }
    first_name_reading    { 'タロウ' }
    family_name_reading   { 'アベ' }
    birth_date            { '2000-01-01' }
  end
end
