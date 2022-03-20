FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password[0..6] }
    password_confirmation { password }
  end

  factory :user_invalid, parent: :user do
    name { nil }
    email { nil }
    password { nil }
    password_confirmation { nil }
  end
end
