require 'rails_helper'

RSpec.describe Category, type: :model do

  describe "バリデーション" do
    context "値が全て存在する場合" do
      it "保存される" do
        category = Category.create(
          name: "test"
        )
        expect(category).to be_valid
      end
    end
    context "nameが空の場合" do
      it "保存されない" do
        category = Category.create(
          name: ""
        )
        expect(category).to be_invalid
      end
    end
  end
  describe "アソシエーション" do
    context "ideas" do
      it "1:Nになっている" do
        expect(Category.reflect_on_association(:ideas).macro).to eq :has_many 
      end
    end
  end
  
end
