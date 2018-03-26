FactoryBot.define do
  factory :ticket do
    association :user
    association :timesheet
  end
end
