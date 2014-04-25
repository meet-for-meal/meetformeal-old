# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    pwd = Faker::Lorem.characters(10)
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password pwd
    password_confirmation pwd
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end

  factory :admin, parent: :user do
    after(:create) {|user| user.add_role(:admin)}
  end
end
