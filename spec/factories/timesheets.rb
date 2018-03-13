FactoryBot.define do
  factory :timesheet do
    start_time Time.zone.local(2019, 12, 6, 12, 0, 0)
    association :user
  end
end
