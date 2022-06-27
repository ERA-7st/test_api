FactoryBot.define do

  factory :category do
    name { "category_A" }
  end

  factory :category2, class: Category do
    name { "category_B" }
  end

end