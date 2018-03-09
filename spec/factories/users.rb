FactoryBot.define do
  factory :user do
    name  "joe"
    email "test@example.com"
    password "password"
    password_confirmation "password"
  end
end
