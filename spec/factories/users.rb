# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end

  factory :admin, parent: :user do
    after(:create) {|user| user.add_role(:admin)}
  end
end
