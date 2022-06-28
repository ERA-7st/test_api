require 'rails_helper'

RSpec.describe IdeasController, type: :controller do

  let(:category) { create(:category) }
  let(:category2) { create(:category2) }
  let!(:idea) { create(:idea, category_id: category.id) }
  let!(:idea2) { create(:idea2, category_id: category2.id) }

  describe "index" do
    it "全てのIdeaを返す" do
      get :index
      expect(response).to be_successful
      expect(controller.instance_variable_get('@ideas').count).to eq 2
    end
    it "特定のIdeaを返す" do
      get :index, params: { category_name: category.name }
      expect(response).to be_successful
      expect(controller.instance_variable_get('@ideas').count).to eq 1
    end
    it "ステータス404を返す" do
      get :index, params: { category_name: "test999" }
      expect(response).not_to be_successful
      expect(response).to have_http_status "404"
    end
  end

  describe "create" do
    context "categoryが存在する場合" do
      it "ideaのみ作成する" do
        expect{
          post :create, params: { category_name: "category_A", body: "test_idea" }
        }.to change(category.ideas, :count).by(1)
        expect(response).to be_successful
        expect(response).to have_http_status "201"
      end
      it "ステータス422を返す" do
        expect{
          post :create, params: { category_name: "category_A", body: "" }
        }.to change(category.ideas, :count).by(0)
        expect(response).to have_http_status "422"
      end
    end
    context "categoryが存在しない場合" do
      it "categoryとideaを作成する" do
        expect{
          post :create, params: { category_name: "category_C", body: "test_idea" }
        }.to change(Category, :count).by(1).and change(Idea, :count).by(1)
        expect(response).to be_successful
        expect(response).to have_http_status "201"
      end
      it "ステータス422を返す" do
        post :create
        expect(response).to have_http_status "422"
      end
    end
    context "categoryとideaが揃わない場合" do
      it "rollbackする" do
        expect{
          post :create, params: { category_name: "", body: "test" }
        }.to change(Category, :count).by(0).and change(Idea, :count).by(0)
        expect(response).to have_http_status "422"
        expect{
          post :create, params: { category_name: "test3", body: "" }
        }.to change(Category, :count).by(0).and change(Idea, :count).by(0)
        expect(response).to have_http_status "422"
      end
    end
  end

end