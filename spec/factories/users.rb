FactoryGirl.define do
  factory :user, class: User do
    email 'example@example.com'
    password 'password'
    password_confirmation 'password'
  end
end
