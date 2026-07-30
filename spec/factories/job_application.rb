# frozen_string_literal: true

FactoryBot.define do
  factory :job_application do
    association :user
    association :job

    status { SUBMITTED }

    trait :submitted do
      status { SUBMITTED }
    end

    trait :reviewed do
      status { REVIEWED }
    end

    trait :rejected do
      status { REJECTED }
    end

    trait :accepted do
      status { ACCPETED }
    end
  end
end
