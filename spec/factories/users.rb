FactoryBot.define do
  factory :user do
    name  "joe"
    email "test@example.com"
    password "password"
    password_confirmation "password"
    role "user"
  end

  factory :fp_user, class: User do
    name "fp"
    email "fp@example.com"
    password "password"
    password_confirmation "password"
    role "fp"
  end
end
