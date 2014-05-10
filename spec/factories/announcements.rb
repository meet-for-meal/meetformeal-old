FactoryGirl.define do
  factory :announcement do
    longitude { rand(-90.000000000...90.000000000) }
    latitude { rand(-90.000000000...90.000000000) }
  end
end
