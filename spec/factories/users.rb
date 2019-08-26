#spec/factories/users
FactoryBot.define do
  factory :user do
    name     { FFaker::Name.html_safe_name }
    kind     { ['admin', 'employee'].sample }
    email    { FFaker::Internet.email }
    password { FFaker::Internet.password }
  end
end
