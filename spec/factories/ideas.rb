FactoryBot.define do

  factory :idea do
    body { "test" }
  end

  factory :idea2, class: Idea do
    body { "test2" }
  end

end