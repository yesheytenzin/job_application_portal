# frozen_string_literal: true

FactoryBot.define do
  factory :job_application do
    association :user
    association :job

    status { :submitted }

    trait :submitted do
      status { :submitted }
    end

    trait :reviewed do
      status { :reviewed }
    end

    trait :rejected do
      status { :rejected }
    end

    trait :accepted do
      status { :accepted }
    end
  end
end
