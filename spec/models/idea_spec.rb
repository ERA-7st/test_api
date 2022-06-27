require "rails_helper"

RSpec.describe Idea, type: :model do

  describe "バリデーション" do
    let(:category) { create(:category) }
    context "値が全て存在する場合" do
      it "保存される" do
        idea = Idea.create(
          body: "test",
          category_id: category.id
        )
        expect(idea).to be_valid
      end
    end
    context "bodyが存在しない場合" do
      it "保存されない" do
        idea = Idea.create(
          body: "",
          category_id: category.id
        )
        expect(idea).to be_invalid
      end
    end
    context "category_idが存在しない場合" do
      it "保存されない" do
        idea = Idea.create(
          body: "test",
          category_id: ""
        )
        expect(idea).to be_invalid
      end
    end
    describe "アソシエーション" do
      context "category" do
        it "N:1になっている" do
          expect(Idea.reflect_on_association(:category).macro).to eq :belongs_to
        end
      end
    end
  end
end