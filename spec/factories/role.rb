FactoryBot.define do
  factory :role do
    name { :applicant }

    trait :admin do
      name { :admin }
    end

    trait :applicant do
      name { :applicant }
    end
  end
end
