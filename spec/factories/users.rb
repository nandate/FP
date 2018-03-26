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

  factory :other_fp_user, class: User do
    name "fp2"
    email "fp2@example.com"
    password "password"
    password_confirmation "password"
    role "fp"
  end
end
