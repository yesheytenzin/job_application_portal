FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 8) }
    password_confirmation { password }

    trait :with_invalid_email do
      email { 'not a valid email' }
    end

    trait :with_short_password do
      password { '123' }
      password_confirmation { '123' }
    end

    trait :with_mismatched_confirmation_password do
      password { Faker::Internet.password(min_length: 8) }
      password_confirmation { Faker::Internet.password(min_length: 8) }
    end
  end
end
