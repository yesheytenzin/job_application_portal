# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    association :job_application

    question do
      create(:question, job: job_application.job)
    end

    answer { Faker::Lorem.sentence }

    trait :empty do
      answer { '' }
    end
  end
end
