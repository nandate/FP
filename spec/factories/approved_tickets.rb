FactoryBot.define do
  factory :approved_ticket do
    association :timesheet
    association :ticket
  end
end
