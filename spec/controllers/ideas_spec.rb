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

end