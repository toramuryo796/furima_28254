FactoryBot.define do
  factory :user do
    nickname              { 'abe' }
    email                 { 'kkk@gamil.com' }
    password              { 'asd123' }
    password_confirmation { password }
  end
end
