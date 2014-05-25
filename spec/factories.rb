FactoryGirl.define do
  factory :user do
    name      "Gerry Boyd"
    email     "tealboyd@gmail.com"
    password  "foobar"
    password_confirmation "foobar"
  end
end