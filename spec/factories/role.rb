FactoryBot.define do
  factory :role do
    name { Faker::Lorem.word.capitalize }

    trait :admin do
      name { 'admin' }
      initialize_with { Role.find_or_create_by!(name: name) }
    end

    trait :applicant do
      name { 'applicant' }
      initialize_with { Role.find_or_create_by!(name: name) }
    end
  end
end
