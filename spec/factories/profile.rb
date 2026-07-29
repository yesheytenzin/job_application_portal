# frozen_string_literal: true

FactoryBot.define do
  sequence(:username) { |n| "username#{n}" }
  sequence(:phone) { |n| "+97517#{n.to_s.rjust(6, '0')}" }

  factory :profile do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { generate(:username) }
    phone { generate(:phone) }
    address { Faker::Address.full_address }
    association :user, factory: :user
  end
end
