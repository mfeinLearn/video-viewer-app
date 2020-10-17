FactoryGirl.define do
  factory :comment do
    content { Faker::Lorem.paragraph }
    rating { Faker::Number.between(from: 0, to: 5)  }
    video
  end
end
