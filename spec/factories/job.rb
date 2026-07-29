# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    title { Faker::Job.title }
    description { Faker::Lorem.sentence }
    min_salary { Faker::Number.between(from: 30000, to: 31000) }
    max_salary { Faker::Number.between(from: 59000, to: 60000) }
    status { DRAFT }
    association :user, factory: :user

    trait :draft do
      status { DRAFT }
    end

    trait :open do
      status { OPEN }
    end

    trait :close do
      status { CLOSED }
    end
  end
end
