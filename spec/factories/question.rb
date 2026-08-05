# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    association :job

    question { Faker::Lorem.question }

    trait :short do
      question { 'Why?' }
    end

    trait :long do
      question { Faker::Lorem.paragraph }
    end
  end
end
